import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
import {startReviewedService} from './reviewed-service.mjs';
import {parseChangePolicy} from '../tools/change-review.mjs';

// A real consumer of a required value-bound plan, including an include and a
// substitution side effect. Port 0 requests an owned ephemeral loopback port.
const root=new URL('./transition-review/',import.meta.url);
const active=await startReviewedService({
  before:{file:fileURLToPath(new URL('before.conf',root))},
  after:{file:fileURLToPath(new URL('after.conf',root))},
  transitions:parseChangePolicy(fs.readFileSync(new URL('transitions.json',root),'utf8'))
});
try{
  const response=await fetch(active.url);
  console.log(JSON.stringify({accepted:active.report.accepted,changes:active.report.changes.length,status:response.status,response:await response.text()}));
}finally{await new Promise((resolve,reject)=>{active.server.close(error=>error?reject(error):resolve());active.server.closeAllConnections();});}
