import fs from 'node:fs';
import http from 'node:http';
import {createHash} from 'node:crypto';
import {Config} from '../tools/config.mjs';
import {reviewFiles,previewTransitionFiles} from '../tools/change-review.mjs';

function readServiceConfig(report,spec){
  const fingerprints=new Map(report.readSets.after.map(entry=>[entry.path,entry.sha256]));
  const config=Config.loadFile(spec.file,{fallbackFiles:spec.fallbackFiles??[],classpath:spec.classpath??[],network:false,environment:{},onRead:entry=>{
    if(fingerprints.get(entry.path)!==entry.sha256)throw Error('Configuration changed before service activation');
  }});
  for(const [file,digest] of fingerprints){
    if(createHash('sha256').update(fs.readFileSync(file)).digest('hex')!==digest)throw Error('Configuration changed before service activation');
  }
  const port=config.getInt('service.port');
  const message=config.getString('service.message');
  if(port<0||port>65535)throw RangeError('Invalid service port');
  return {port,message};
}

/** Check the demo's typed config against a transition preview without listening. */
export function checkReviewedServiceConfig(options){
  const report=previewTransitionFiles(options);
  if(!report.accepted)return {...report,serviceConfigChecked:false};
  readServiceConfig(report,report.previewInputs.after);
  return {...report,serviceConfigChecked:true};
}

/** A small application consumer: rejected configuration never opens a listener. */
export async function startReviewedService(options){
  const expected=options.expectedPreviewHash;
  if(expected!==undefined&&(typeof expected!=='string'||!/^[0-9a-f]{64}$/i.test(expected)))throw new TypeError('expectedPreviewHash must be a 64-digit SHA-256 hex string');
  const report=expected===undefined?reviewFiles({...options,requireAllRulesUsed:options.requireAllRulesUsed??true}):previewTransitionFiles(options);
  if(!report.accepted){
    const error=new Error('Configuration policy rejected service activation');
    error.name='PolicyRejected';error.report=report;throw error;
  }
  if(expected!==undefined&&report.previewHash!==expected.toLowerCase()){
    const error=new Error('Configuration inputs or transition policy changed since preview');
    error.name='PreviewChanged';error.report={...report,accepted:false,previewMatches:false};throw error;
  }
  const {port,message}=readServiceConfig(report,expected===undefined?options.after:report.previewInputs.after);
  const server=http.createServer((_request,response)=>{response.writeHead(200,{'Content-Type':'text/plain; charset=utf-8'});response.end(message);});
  await new Promise((resolve,reject)=>{server.once('error',reject);server.listen(port,'127.0.0.1',resolve);});
  return {server,report,url:`http://127.0.0.1:${server.address().port}/`};
}
