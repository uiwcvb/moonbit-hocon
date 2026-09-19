import fs from 'node:fs';
const primitive=JSON.parse(fs.readFileSync(new URL('../evidence/double-parse-vectors.json',import.meta.url),'utf8'));
const digits=JSON.parse(fs.readFileSync(new URL('../evidence/numeric-characters.json',import.meta.url),'utf8'));
const text=new Set(['','0','-0','+0','00','-00','-0.0','-0e0','-0e-99999','-1e-99999','-0x0p0','NaN','-NaN','Infinity','-Infinity','1f','1D','0x1p63','0x1.fffffffffffffp62','0x1p-1074','１２.３','𝟘','-𝟘','１２e３','\u00a0-0\u00a0','--0','1_0']);
const literals=new Set(['0','-0','-0.0','-0e0','-1e-99999','0.1','1e23','1e100','-1e200']);
for(let p=0n;p<=64n;p++)for(const delta of [-2n,-1n,0n,1n,2n]){
 const n=(1n<<p)+delta;
 for(const value of [String(n),String(-n)]){text.add(value);literals.add(value);}
}
for(const start of digits.starts){
 const encode=s=>s.replace(/[0-9]/g,d=>String.fromCharCode(start+Number(d)));
 for(const value of ['0','-0','+0','01','-12','2147483647','2147483648','9007199254740993','9223372036854775807','-9223372036854775808','9223372036854775808','-9223372036854775809'])text.add(encode(value));
}
for(let code=0;code<=33;code++)for(const value of ['-0','-000','-0.0','-1e-9999'])text.add(String.fromCharCode(code)+value+String.fromCharCode(code));
for(let i=0;i<primitive.texts.length;i+=47)text.add(primitive.texts[i]);
for(let i=0;i<primitive.texts.length;i+=191){const value=primitive.texts[i];if(/^-?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?$/.test(value))literals.add(value);}
export const cases=[...[...text].map(value=>({kind:'text',value})),...[...literals].map(value=>({kind:'source',value}))];
