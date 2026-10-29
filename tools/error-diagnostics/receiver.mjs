import fs from 'node:fs';
const rows=fs.readFileSync(process.argv[2],'utf8').trimEnd().split('\n').map(line=>JSON.parse(line));
const rejected=rows.filter(row=>!row.diagnostic||typeof row.diagnostic.name!=='string'||typeof row.diagnostic.message!=='string').map(row=>row.stage);
if(rejected.length){console.log(JSON.stringify({accepted:false,rejectedStages:rejected,reason:'missing diagnostic message'}));process.exitCode=2;}
else {
 const items=rows.map(({stage,diagnostic:d})=>({stage,message:d.message,location:d.position?d.position.source+':'+d.position.line+':'+d.position.column:null,problems:(d.problems??[]).map(p=>p.path+':'+p.kind)}));
 console.log(JSON.stringify({accepted:true,items}));
}
