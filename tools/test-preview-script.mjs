import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';

const root=fs.mkdtempSync(path.join(os.tmpdir(),'hocon-preview-script-自带 # % 😀-'));
const cli=fileURLToPath(new URL('./change-review.mjs',import.meta.url));
const example=fileURLToPath(new URL('../examples/preview-bound-service.mjs',import.meta.url));
const beforeValue='脚本迁移前 # % 😀',afterValue='脚本确认后 # % 😀';
const before=path.join(root,'旧 配置.conf'),after=path.join(root,'新 配置.conf'),policy=path.join(root,'迁移 计划.json');
const names=[];
function check(name,fn){fn();names.push(name);}
function run(script,args,cwd=root){
  const child=spawnSync(process.execPath,[script,...args],{encoding:'utf8',cwd,timeout:20000,windowsHide:true});
  assert(!child.error,child.error?.message);assert.equal(child.signal,null);
  return child;
}
function receipt(script,args){const child=run(script,args);assert.equal(child.status,0,child.stderr);assert.equal(child.stderr,'');return JSON.parse(child.stdout);}
function rejected(args,diagnostic){const child=run(example,args);assert.equal(child.status,1);assert.equal(child.stdout,'');assert(child.stderr.includes(diagnostic),child.stderr);return child;}
function noValues(report){const text=JSON.stringify(report);for(const value of [beforeValue,afterValue])assert(!text.includes(value),'preview exposed a configuration value');}
try{
  for(const [side,file] of [['before',before],['after',after]]){
    fs.writeFileSync(file,'include classpath("message.conf")\nservice.copy=${service.message}\n');
    for(const rank of ['first','second']){
      fs.writeFileSync(path.join(root,`${side}-${rank}.conf`),`service.port=0\nservice.batch=${rank==='first'?11:22}\n`);
      const dir=path.join(root,`${side}-cp-${rank}`);fs.mkdirSync(dir);
      const message=rank==='first'?(side==='before'?beforeValue:afterValue):`shadow-${side}`;
      fs.writeFileSync(path.join(dir,'message.conf'),'service.message='+JSON.stringify(message)+'\n');
    }
  }
  fs.writeFileSync(policy,JSON.stringify(['message','copy'].map(key=>({path:['service',key],beforeSource:JSON.stringify(beforeValue),afterSource:JSON.stringify(afterValue)}))));
  function inputs({relative=false,reverseFallback=false,reverseClasspath=false,plan=policy}={}){
    const name=file=>relative?path.relative(root,file):file;
    const args=['--before',name(before),'--after',name(after),'--transition-policy',name(plan)];
    for(const side of ['before','after']){
      for(const rank of reverseFallback?['second','first']:['first','second'])args.push(`--${side}-fallback`,name(path.join(root,`${side}-${rank}.conf`)));
      for(const rank of reverseClasspath?['second','first']:['first','second'])args.push(`--${side}-classpath`,name(path.join(root,`${side}-cp-${rank}`)));
    }
    return args;
  }
  const args=inputs();let preview;
  check('caller-file preview matches generic CLI receipt across processes',()=>{
    const generic=receipt(cli,[...args,'--preview-receipt']);
    preview=receipt(example,['--preview',...args,'--preview-receipt']);
    assert(preview.accepted);assert.deepEqual(preview,generic);noValues(preview);
  });
  check('caller activation consumes selected Unicode HTTP response and exits',()=>{
    const active=receipt(example,['--activate',preview.previewHash.toUpperCase(),...args]);
    assert.deepEqual(active,{accepted:true,previewHash:preview.previewHash,status:200,response:afterValue});
  });
  check('ordered fallback and classpath arguments survive the script boundary',()=>{
    for(const side of ['before','after']){
      const spec=preview.previewInputs[side];
      assert.deepEqual(spec.fallbackFiles,['first','second'].map(rank=>path.join(root,`${side}-${rank}.conf`)));
      assert.deepEqual(spec.classpath,['first','second'].map(rank=>path.join(root,`${side}-cp-${rank}`)));
      for(const file of spec.fallbackFiles)assert(preview.readSets[side].some(entry=>entry.path===file));
      assert(preview.readSets[side].some(entry=>entry.path===path.join(spec.classpath[0],'message.conf')));
    }
  });
  check('relative paths use caller cwd and retain the absolute-input receipt',()=>{
    const relative=receipt(example,['--preview',...inputs({relative:true})]);
    assert.deepEqual(relative,preview);
  });
  check('relative-path activation can consume the earlier absolute-path receipt',()=>{
    const active=receipt(example,['--activate',preview.previewHash,...inputs({relative:true})]);
    assert.equal(active.status,200);assert.equal(active.response,afterValue);
  });
  check('changed fallback order produces an accepted but different preview',()=>{
    const reversed=receipt(example,['--preview',...inputs({reverseFallback:true})]);
    assert(reversed.accepted);assert.deepEqual(reversed.changes,preview.changes);assert.notEqual(reversed.previewHash,preview.previewHash);
    assert.deepEqual(reversed.previewInputs.after.fallbackFiles,[...preview.previewInputs.after.fallbackFiles].reverse());
  });
  check('activation refuses a changed fallback order with the earlier hash',()=>rejected(['--activate',preview.previewHash,...inputs({reverseFallback:true})],'PreviewChanged'));
  check('changed classpath selection fails the plan and cannot activate',()=>{
    const child=run(example,['--preview',...inputs({reverseClasspath:true})]);assert.equal(child.status,2);assert.equal(child.stderr,'');
    const report=JSON.parse(child.stdout);assert(!report.accepted);assert(report.mismatches.length>0);noValues(report);
    rejected(['--activate',preview.previewHash,...inputs({reverseClasspath:true})],'PolicyRejected');
  });
  check('partial custom input cannot silently use the bundled after file',()=>rejected(['--preview','--before',before,'--transition-policy',policy],'Custom inputs require'));
  check('custom preview requires a value-bound plan rather than legacy permissions',()=>{
    const permissions=path.join(root,'permissions.json');fs.writeFileSync(permissions,'[]');
    rejected(['--preview','--before',before,'--after',after,'--policy',permissions],'Custom inputs require');
  });
  check('invalid mode/hash/duplicate/unknown/conflicting arguments fail',()=>{
    for(const [argv,diagnostic] of [
      [[], 'Usage:'],[['--other'],'Usage:'],[['--activate'],'Usage:'],[['--activate',...args],'Usage:'],
      [['--activate','short',...args],'expectedPreviewHash'],
      [['--preview',...args,'--unknown','x'],'Usage:'],
      [['--preview',...args,'--before',before],'Duplicate input'],
      [['--preview',...args,'--policy',policy],'Duplicate or conflicting policy']
    ])rejected(argv,diagnostic);
  });
  check('an incorrect valid hash cannot activate caller inputs',()=>rejected(['--activate','0'.repeat(64),...args],'PreviewChanged'));
  check('malformed caller policy preserves the safe diagnostic',()=>{
    const bad=path.join(root,'malformed.json'),marker='private-policy-marker-42';fs.writeFileSync(bad,'[{"afterSource":"'+marker+'",}]');
    const child=rejected(['--preview',...inputs({plan:bad})],'Policy must contain valid JSON');
    assert(!child.stderr.includes(marker));
  });
  check('caller policy keeps the existing byte limit',()=>{
    const large=path.join(root,'oversized.json');fs.writeFileSync(large,' '.repeat(524289));
    rejected(['--preview',...inputs({plan:large})],'at most 524288 bytes');
  });
  check('a rejected custom preview remains rejected even with its own hash',()=>{
    const empty=path.join(root,'empty-plan.json');fs.writeFileSync(empty,'[]');
    const child=run(example,['--preview',...inputs({plan:empty})]);assert.equal(child.status,2);assert.equal(child.stderr,'');
    const report=JSON.parse(child.stdout);assert(!report.accepted);assert.match(report.previewHash,/^[0-9a-f]{64}$/);noValues(report);
    rejected(['--activate',report.previewHash,...inputs({plan:empty})],'PolicyRejected');
  });
  console.log(JSON.stringify({checks:names.length,names}));
}finally{
  const owned=path.resolve(root);
  assert.equal(path.dirname(owned),path.resolve(os.tmpdir()));assert(path.basename(owned).startsWith('hocon-preview-script-'));
  fs.rmSync(owned,{recursive:true,force:true});
}
