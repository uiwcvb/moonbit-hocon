import fs from 'node:fs';
const render=JSON.parse(fs.readFileSync(new URL('../evidence/double-render-vectors.json',import.meta.url),'utf8'));
const unique=new Set(render.expected),add=text=>unique.add(text);
const signed=text=>{add(text);add('-'+text);};
const five1075=5n**1075n,units=new Set();
for(let i=0n;i<=128n;i++)units.add(i);
for(let power=0n;power<=56n;power++)for(const delta of [-1n,0n,1n])units.add((1n<<power)+delta);
for(const unit of units){
 const midpoint=(2n*unit+1n)*five1075;
 for(const delta of [-1n,0n,1n])signed((midpoint+delta)+'e-1075');
}
for(const unit of [0n,1n,(1n<<52n)-1n])for(const extra of [1,2,16,32,128,256,768,1024,4096]){
 const midpoint=(2n*unit+1n)*five1075*10n**BigInt(extra);
 for(const delta of [-1n,0n,1n])signed((midpoint+delta)+'e-'+(1075+extra));
}
for(const exponent of [-100000,-10000,-1000,-325,-324,-323,-309,-308,-307,-22,-1,0,22,23,308,309,10000,100000])
 for(const coefficient of ['0','1','0001','0.0001','1.','1.25','9.999999999999999','12345678901234567890123456789'])signed(coefficient+'e'+exponent);
for(const exponent of ['9'.repeat(40),'-'+'9'.repeat(40),'0'.repeat(128)+'324'])for(const coefficient of ['0','1','1.1'])signed(coefficient+'e'+exponent);
for(const count of [767,768,769,1000,4096,9000]){
 signed('0.'+'0'.repeat(count)+'1e'+(count-323));
 signed('1'+'0'.repeat(count)+'e-'+(count+323));
}
let random=0x47547ae1;
const draw=()=>{random=(Math.imul(random,1664525)+1013904223)>>>0;return random;};
for(let i=0;i<1024;i++){
 let digits=String(draw()%9+1);for(let j=1,n=draw()%96+1;j<n;j++)digits+=draw()%10;
 const point=draw()%(digits.length+1),exponent=Number(draw()%1600)-1200;
 const text=digits.slice(0,point)+'.'+digits.slice(point)+'e'+exponent;
 add((i%2?'-':'+')+text+['','f','D'][i%3]);
}
// Long nonzero suffixes exercise conclusive prefix intervals; the midpoint
// neighbors above exercise intervals that must expand or retain exact fallback.
for(let i=0;i<128;i++){
 let digits=String(draw()%9+1),count=769+draw()%1024;
 for(let j=1;j<count;j++)digits+=draw()%10;
 if(digits.endsWith('0'))digits=digits.slice(0,-1)+'1';
 signed(digits+'e-'+(count+307+draw()%17));
}
for(let c=0;c<=33;c++)for(const text of ['1e-323','-0.0','NaN','Infinity'])add(String.fromCharCode(c)+text+String.fromCharCode(c));
for(const text of ['', '.', '+', '-', '+.', '-.', 'e1','1e','1e+','1e-','1e1e1','1..0','--1','+-1','1_0','nan','inf','1 0','\u00a01\u00a0','１２.３','1dD','0x','0x1','0x1p','0x1.8p-1074','-0x1p-1075','0x0.fffffffffffffp-1022','0x1.00000000000008p-1022','0x1p1024','+NaN','-NaN','NaNf','Infinityd'])add(text);
export const texts=[...unique];
