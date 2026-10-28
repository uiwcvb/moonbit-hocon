import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {parseChangePolicy,previewTransitionFiles,readReviewOptions} from '../tools/change-review.mjs';
import {checkReviewedServiceConfig,startReviewedService} from './reviewed-service.mjs';

// Two separate calls: first inspect --preview, then explicitly supply its hash.
const [mode,...args]=process.argv.slice(2);
const expected=mode==='--activate'?args.shift():undefined;
if(!['--preview','--check','--activate'].includes(mode)||(mode==='--activate'&&(!expected||expected.startsWith('--'))))throw new Error('Usage: node examples/preview-bound-service.mjs (--preview | --check | --activate PREVIEW_SHA256) [--before FILE --after FILE --transition-policy FILE ...]');
const root=new URL('./transition-review/',import.meta.url);
const options=args.length?readReviewOptions(args):{
  before:{file:fileURLToPath(new URL('before.conf',root))},
  after:{file:fileURLToPath(new URL('after.conf',root))},
  transitions:parseChangePolicy(fs.readFileSync(new URL('transitions.json',root),'utf8'))
};
if(!options.before.file||!options.after.file||!Array.isArray(options.transitions))throw new TypeError('Custom inputs require --before, --after and --transition-policy');
if(mode==='--preview'||mode==='--check'){
  const report=mode==='--check'?checkReviewedServiceConfig(options):previewTransitionFiles(options);
  console.log(JSON.stringify(report,null,2));
  if(!report.accepted)process.exitCode=2;
}else{
  const active=await startReviewedService({...options,expectedPreviewHash:expected});
  try{
    const response=await fetch(active.url);
    console.log(JSON.stringify({accepted:active.report.accepted,previewHash:active.report.previewHash,status:response.status,response:await response.text()}));
  }finally{await new Promise((resolve,reject)=>{active.server.close(error=>error?reject(error):resolve());active.server.closeAllConnections();});}
}
