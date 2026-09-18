export {execute} from './value-cases.mjs';
export const requests=[];
function pair(a,b){return {source:'{}',calls:[{op:'new',source:a},{op:'new',source:b},{op:'equals',target:1,other:2},{op:'equals',target:2,other:1},{op:'hash',target:1},{op:'hash',target:2}]};}
const nums=['-2147483648','-2147483647','2147483647','2147483648','-4294967296','4294967296','-9223372036854775808','9223372036854775807','9007199254740993','9007199254740993.0','1','1.0000000000000002','1e30','1e-300','-5e-324','-0.0','0.0','0','-1','-1.0'];
for(const a of nums)for(const b of nums)requests.push(pair(a,b));
const keys=['a','z','Aa','BB','a.long','k10','k2','😀'];
for(const first of keys)for(const second of keys.filter(k=>k!==first))for(const reverse of [false,true]){
 const entries=[[first,'text'],[second,'0']],other=[[first,'${missing}'],[second,'1']];
 if(reverse){entries.reverse();other.reverse();}
 const object=entries=>'{'+entries.map(([key,value])=>JSON.stringify(key)+'='+value).join(',')+'}';
 requests.push(pair(object(entries),object(other)));
 requests.push(pair(object(entries),object([...other,['missing-key','2']])));
 requests.push({source:'{}',calls:[{op:'new',source:object(other)},{op:'new',source:'text'},{op:'contains-value',target:1,other:2}]});
}
const needles=['1','1.0','0','-1','null','"1"','${missing}','text','{x=1}','{x=1.0}'];
for(const size of [0,1,8,64,512])for(const needle of needles)for(const order of ['early','late','absent']){
 const items=Array.from({length:size},(_,i)=>String(i+2));
 if(items.length&&order==='early')items[0]='1';
 if(items.length&&order==='late')items[items.length-1]='1';
 const source='['+items.join(',')+']';
 requests.push({source:'{}',calls:[{op:'new',source},{op:'new',source:needle},{op:'index-of',target:1,other:2},{op:'last-index-of',target:1,other:2},{op:'contains-value',target:1,other:2}]});
}
for(const items of ['[${missing},text,1]','[text,${missing},1]','[1,text,${missing}]','[{a=${missing}},{a=text},{b=1}]','[[${missing}],[text],[]]'])for(const needle of ['text','1','${missing}','{a=text}','{b=1}','[text]','[]'])requests.push({source:'{}',calls:[{op:'new',source:items},{op:'new',source:needle},{op:'index-of',target:1,other:2},{op:'last-index-of',target:1,other:2},{op:'contains-value',target:1,other:2}]});
for(const size of [8,32,128])for(const mismatch of ['none','first','last','key','length']){
 const values=Array.from({length:size},(_,i)=>({key:'k'+i,value:i%2?'"'+i+'"':String(i)}));
 const object=v=>'{'+v.map(({key,value})=>JSON.stringify(key)+'='+value).join(',')+'}';
 const changed=structuredClone(values);
 if(mismatch==='first')changed[0].value='-1';
 if(mismatch==='last')changed.at(-1).value='-1';
 if(mismatch==='key')changed[0].key='new-key';
 if(mismatch==='length')changed.pop();
 requests.push(pair(object(values),object(changed)));
}
