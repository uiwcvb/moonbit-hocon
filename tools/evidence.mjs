import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {createHash} from 'node:crypto';
const root=fileURLToPath(new URL('../',import.meta.url));
export function sourceHashes(){
 const names=[];
 function walk(dir){for(const entry of fs.readdirSync(path.join(root,dir),{withFileTypes:true})){
  const relative=dir?dir+'/'+entry.name:entry.name;
  if(entry.isDirectory()){if(['cmd','tools','web'].includes(entry.name)||dir==='cmd')walk(relative);}
  else if(/\.(mbt|mbti|mjs|java|pkg|mod)$/.test(entry.name)||['verify.ps1'].includes(entry.name))names.push(relative);
 }}
 walk('');names.sort();return Object.fromEntries(names.map(name=>[name,createHash('sha256').update(fs.readFileSync(path.join(root,name))).digest('hex')]));
}
