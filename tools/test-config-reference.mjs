import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';
import {readFileSync,writeFileSync} from 'node:fs';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
import {isDeepStrictEqual} from 'node:util';
import {inspect_json} from '../web/engine.mjs';
import {sourceHashes} from './evidence.mjs';
const requests=[];
const listEnvironment={HOCON_REFERENCE_LIST_0:'one',HOCON_REFERENCE_LIST_1:'two',HOCON_REFERENCE_LIST_3:'ignored'};
function add(source,extra={}){requests.push({source,...extra});}
for(const source of [
'', '{}','a=1\nb=true\nc=null\nd="1"','a=-1.25e+3','a=[1,false,null,{x=2},[3,4],]','a=[1\n2\n3]','a=[1 2]',
'a={x=1}\na={y=2}','a={x=1}\na=null\na={y=2}','a=[1] [2,3]','a={x=1} {y=2}','a=[1,true]\nb=${a}',
'a=${?NONE}','a=7\na=${?NONE}','a=[0,${?NONE},1]','a=${?NONE}suffix','a="prefix"${?NONE}','a=${?NONE} x','a=x ${?NONE} y','a=${?NONE} " x"','a=${?NONE}${n}\nn=1',
'"a.b"=7\nz=${"a.b"}','host=api\nport=80\nurl=${host}":"${port}','a={x=1}\nb=${a}\nb={y=2}','a={x=1}\nb=${a}\nc=${b.x}',
'a=1\na=${a}x','a=${?a}x','a={x=1}\na=${a}\nb=${a}','z={x=1\nx=${z.x}y}\na=${z}',
'a={b=${?a}}','a={b=${a}}','a=1\nb=2\na=${b}\nb=${a}','a=[1]\na+=[2,3]','a+={x=1}','a+=${missing}','a+=${?NONE}',
'a={x=1,y=${a.x}}\na.x=2','a=${a}\na={x=1}','a=${missing}\na=3','a.b=1\na.b=${a.b}z','a={x={c=1}}\na=${a.x}\na={x=2}',
'a=1\na=${a}\na=${a}','a=1\na=${a}x\na=${a}y','a=1\na=${b}\nb=${a}x','a=${b}\nb=${c}\nc=${a}',
'a={x=1}\na={y=${a.x}}','a=[${a}]','a=[${?a}]','a={x=${?a.x}}','a={x=3}\na.x=${a.x}0',
'a=${obj}\na.x=2\nobj={x=1,y=3}','a=${obj}\na.x=${a.x}z\nobj={x=1,y=3}','a=${obj}\na.x=2\nb=${a.y}\nobj={x=1,y=3}',
'a=[]foo','a=[]"foo"','a=[]${x}\nx=foo','a=[]${x}\nx="foo"','a=[]${x}\nx=foo bar','a=text [1]','a=[]falsefoo','a=[]5foo','a=[]-foo',
'a=[] 1efoo','a=[]true','a=[]5','a={}false','a={} foo bar','a=[]\ntext','a={} ${x}\nx=text',
'a b.c"d"=1','a . b=1','"a" . "b"=1','""=1','a."".b=1','a..b=1','.a=1','a.=1','a."b.c"=1','1.2.3=4','truefoo=1',
'a="""hello\nworld"""','a="""a\\nb"""','a="""x""""','a="""x"""""','a="""unfinished','a=hello|world','a=foo(bar)','a=foo;bar','a=foo+bar','a=foo@bar',
'a={x=1','a=[1','a=[1,,2]','a=[,1]','a=1,,b=2','a={} [1]','a=${missing}','a=${b}\nb=${a}','a="bad\nstring"','a=$ {x}','a=${ ?x}','a=${? x}','a=${x\ny}','a=${"x.y"}\n"x.y"=1',
'include "missing"\na=1','include required("missing")','include=1','include "x" "y"','a=include','foo include=1',
])add(source);
for(const literal of ['0','00','01','-01','00.5','1.','-.5','.5','-','-foo','1e','1e+','1e-2','1e+2','1e3foo','truefoo','falsehood','nullary','1_000','NaN','Infinity','0x12','1.2.3','1234567890123456789']){add('a='+literal);add('a="prefix"'+literal);add('a=[]'+literal);}
for(const ws of ['\t','\r','\v','\f','\u001c','\u001f','\u00a0','\u1680','\u2000','\u2007','\u2028','\u2029','\u202f','\u205f','\u3000','\ufeff']){add(`a=${ws}one${ws}two${ws}`);add(`a${ws}b=1`);}
for(const old of ['1','"x"','[1]','{x=1}','null','${?NONE}'])for(const rhs of ['${a}','${?a}','${a} x','${a} [2]','${a} {y=2}'])add(`a=${old}\na=${rhs}`);
for(const body of ['x=1\ny=${x}','x=1\ny=${outside}','x=1\ny=${?NONE}','a=[1]\na+=2','x=1\nx=${x}y','include "inner"\nx=7']){
 const includes={part:body,inner:'y=${x}'};add('include "part"\noutside=3',{includes});add('nested {include "part"}\nnested.x=2\nx=10\noutside=3',{includes});
}
for(const source of ['a {include "part"}','a.b {include "part"}','a {include "outer"}\nx=10','a {include "part"}\na.x=9','a {include "part"}\nx=11','a {include "part"}\na.x=null','include required(file("part"))','include\nrequired(\n"part"\n)','include required("missing")'])add(source,{includes:{part:'y=${x}',outer:'b {include "part"}\nx=5'}});
for(const source of ['a=${x}','a=${?x}','a=${x}\nx=null','a=${x}\nx=3','a=${"x.y"}','a=${?missing}'])add(source,{environment:{x:'environment','x.y':'dotted'}});
for(const source of ['a=${a}x','a=${a}','a={b=2}','a=${x}','a=${?NONE}','a=[1]\na+=2'])add(source,{fallbacks:['a="base"\nx=1','a=9\nx=2\nz=3']});
for(const getter of ['string','boolean','int','long','double','duration','bytes','memory','list','has','null'])for(const value of ['1','1.5','"1.5"','"true"','"yes"','true','null','{0=a,2=b,x=c}','"1.25ms"','"2 KiB"','"off"','"TRUE"','[]','{}','"9007199254740993"','9223372036854775807','" 1 "','"1e3"'])add('a='+value,{getter,path:'a'});
for(const unit of ['ns','nano','nanos','nanosecond','nanoseconds','us','micro','micros','microsecond','microseconds','ms','milli','millis','millisecond','milliseconds','s','second','seconds','m','minute','minutes','h','hour','hours','d','day','days','w','week','µs','NANOSECONDS'])add('a='+JSON.stringify('1.5 '+unit),{getter:'duration',path:'a'});
for(const unit of ['','b','B','byte','bytes','k','K','kb','kB','KB','Ki','KiB','kibibyte','kilobyte','M','MB','MiB','m','mb','g','GB','GiB','T','TB','TiB','P','PB','PiB','E','EB','EiB','ZB','ZiB','YB','YiB'])for(const getter of ['memory','bytes'])add('a='+JSON.stringify('2 '+unit),{getter,path:'a'});
for(const getter of ['int','long','bytes','memory','duration'])for(const value of ['2147483648','9223372036854775807','9223372036854775808','-1','"1.2e3ms"','"999999999999999999999999ms"','"1e30 bytes"','"-0.1ns"','"-1 byte"','"NaN"'])add('a='+value,{getter,path:'a'});
for(const source of ['a={high=1}','a=${a}z','a=${?NONE}','a=[1]'])for(const fallback of ['a=0','a=${x}\nx=0','a=${a}y','a={middle=2}'])add(source,{fallbacks:[fallback,'a={low=3}\nx=4']});
for(const value of ['NaN','Infinity','-Infinity','0x1.0p3','1f','1d','+3',' 1 ','1e309'])add('a='+JSON.stringify(value),{getter:'double',path:'a'});
for(const value of ['0x1.fffffffffffffp1023','0x1.fffffffffffff8p1023','0x0.0000000000001p-1022','0x1p-1075','0x1.0000000000001p-1075','0x1.fffffffffffffp-1023','-0x1p-1074','0x0p999999','0x1p999999999999','0x1p-999999999999','0x1.00000000000018p0','0x1.00000000000008p0','0x.8p0','0x1.p0f','0x','0x1','0x.p0','0xp0','0x1p','0x1p+','1_000','nan','infinity','inf','NaNf','--1'])add('a='+JSON.stringify(value),{getter:'double',path:'a'});
for(const getter of ['int','long','memory','bytes'])for(const value of ['1_000','0x1p4','1f','1e309','NaN','inf','Infinity'])add('a='+JSON.stringify(value),{getter,path:'a'});
for(const source of ['a=[1,2]\nb=${a[]}','a=1\nb=${a[]}','a=null\nb=${?a[]}','b=${?absent[]}','a={0=x,1=y}\nb=${a[]}'])add(source);
for(const source of ['a=${HOCON_REFERENCE_LIST[]}','a=${?HOCON_REFERENCE_LIST[]}','a=${HOCON_REFERENCE_LIST[]}\nHOCON_REFERENCE_LIST=null','a=${HOCON_REFERENCE_LIST[]}\nHOCON_REFERENCE_LIST=[3]'])add(source,{systemEnvironment:true,environment:listEnvironment});
let references;
if(process.argv.includes('--golden')){const saved=JSON.parse(readFileSync(new URL('../evidence/config-reference-vectors.json',import.meta.url),'utf8'));assert.deepEqual(saved.requests,requests);references=saved.references;}
else{
 const jar=process.env.HOCON_REFERENCE_JAR;assert(jar,'Set HOCON_REFERENCE_JAR');
 const r=spawnSync(process.env.JAVA??'java',['-cp',jar,fileURLToPath(new URL('HoconOracle.java',import.meta.url))],{input:requests.map(JSON.stringify).join('\n')+'\n',encoding:'utf8',windowsHide:true,timeout:45000,maxBuffer:16*1024*1024,env:{...process.env,...listEnvironment}});assert.equal(r.status,0,r.stderr||String(r.error));
 references=r.stdout.trim().split(/\r?\n/).map(JSON.parse);assert.equal(references.length,requests.length);
 writeFileSync(new URL('../evidence/config-reference-vectors.json',import.meta.url),JSON.stringify({reference:jar.split(/[\\/]/).at(-1),requests,references},null,2)+'\n');
}
const failures=[];
requests.forEach((request,i)=>{const actual=JSON.parse(inspect_json(JSON.stringify(request)));const reference=references[i];if(actual.accepted!==reference.accepted||(actual.accepted&&!isDeepStrictEqual(actual.value,reference.value)))failures.push({request,actual,reference});});
writeFileSync(new URL(`../evidence/config-reference-${process.argv.includes('--golden')?'replay':'validation'}.json`,import.meta.url),JSON.stringify({utc:new Date().toISOString(),mode:process.argv.includes('--golden')?'saved vectors':'live Lightbend Config',reference:process.env.HOCON_REFERENCE_JAR?.split(/[\\/]/).at(-1),jarSha256:process.env.HOCON_REFERENCE_JAR?createHash('sha256').update(readFileSync(process.env.HOCON_REFERENCE_JAR)).digest('hex'):undefined,total:requests.length,passed:requests.length-failures.length,failed:failures.length,sourceHashes:sourceHashes(),failures},null,2)+'\n');
console.log(`${requests.length-failures.length}/${requests.length} configuration reference cases agree`);for(const f of failures.slice(0,45))console.log(JSON.stringify(f));if(failures.length)process.exitCode=1;
