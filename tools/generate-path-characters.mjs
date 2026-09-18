import assert from 'node:assert/strict';
import fs from 'node:fs';
import {spawnSync} from 'node:child_process';
import {fileURLToPath} from 'node:url';
const dataFile=new URL('../evidence/path-characters.json',import.meta.url);
let data;
if(process.argv.includes('--live')){
 const run=spawnSync(process.env.JAVA??'java',[fileURLToPath(new URL('./PathCharacters.java',import.meta.url))],{encoding:'utf8',windowsHide:true,timeout:30000});
 assert.equal(run.status,0,run.stderr||String(run.error));data=JSON.parse(run.stdout);
 fs.writeFileSync(dataFile,JSON.stringify(data,null,2)+'\n');
}else data=JSON.parse(fs.readFileSync(dataFile,'utf8'));
let output='// Generated JDK '+data.java+' BMP letter/digit ranges; supplementary UTF-16 pairs are quoted.\n// Regenerate with node tools/generate-path-characters.mjs [--live].\n///|\nlet path_character_ranges : Array[(Int, Int)] = [\n';
for(const [low,high] of data.ranges)output+=`  (${low}, ${high}),\n`;
output+=`]\n\n///|\nfn path_character(c : Char) -> Bool {
  let cp = c.to_int()
  if cp == 45 || cp == 95 { return true }
  let mut low = 0
  let mut high = path_character_ranges.length()
  while low < high {
    let middle = low + (high - low) / 2
    let range = path_character_ranges[middle]
    if cp < range.0 { high = middle }
    else if cp > range.1 { low = middle + 1 }
    else { return true }
  }
  false
}\n`;
fs.writeFileSync(new URL('../path_characters.mbt',import.meta.url),output);
console.log(data.ranges.length+' JDK path character ranges generated');
