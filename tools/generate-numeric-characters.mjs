import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
const dataFile=new URL('../evidence/numeric-characters.json',import.meta.url);
let data;
if(process.argv.includes('--live')){
 const run=spawnSync(process.env.JAVA??'java',[fileURLToPath(new URL('./NumericCharacters.java',import.meta.url))],{encoding:'utf8',windowsHide:true,timeout:30000});
 assert.equal(run.status,0,run.stderr||String(run.error));data=JSON.parse(run.stdout);
 fs.writeFileSync(dataFile,JSON.stringify(data,null,2)+'\n');
}else data=JSON.parse(fs.readFileSync(dataFile,'utf8'));
let output=`// Generated JDK ${data.java} radix-10 digit blocks. Java integer parsing uses UTF-16 chars.
// Regenerate with node tools/generate-numeric-characters.mjs [--live].
///|
let numeric_digit_starts : Array[Int] = [${data.starts.join(', ')}]

///|
fn numeric_digit(cp : Int) -> Int {
  if cp >= 48 && cp <= 57 { return cp - 48 }
  if cp < 128 || cp > 65535 { return -1 }
  let mut low = 0
  let mut high = numeric_digit_starts.length()
  while low < high {
    let middle = low + (high - low) / 2
    let start = numeric_digit_starts[middle]
    if cp < start { high = middle }
    else if cp > start + 9 { low = middle + 1 }
    else { return cp - start }
  }
  -1
}
`;
fs.writeFileSync(new URL('../numeric_characters.mbt',import.meta.url),output);
console.log(data.starts.length+' JDK numeric digit blocks generated');
