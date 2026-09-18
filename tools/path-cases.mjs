const paths=new Set(['','a','a.b','1.2','-1.0','a-b._0','null.true.false','a..b','.a','a.','""','a."".b','a."b.c"','a"b"c','"a""b"','"a\\u002Eb"','"a\\nb"','"a\\\"b"','"a\\\\b"','a#comment','a//comment','a/*b*/','"a".b # tail','a\nb','a.\nb','a . b','  a  ','a\tb','a\r\nb','a+=b']);
for(let cp=0;cp<128;cp++){
 const c=String.fromCodePoint(cp);
 for(const p of [c,'a'+c+'b',c+'a','a'+c,'a.'+c+'.b',JSON.stringify(c)])paths.add(p);
}
for(const cp of [160,5760,8192,8193,8202,8203,8232,8233,8239,8287,12288,65279,0x3b1,0x4e2d,0xff11,0x1f600]){
 const c=String.fromCodePoint(cp);for(const p of [c,'a'+c+'b',c+'a','a'+c,'a.'+c+'.b',JSON.stringify(c)])paths.add(p);
}
for(const segment of ['x','1','-2','_','a-b','null','true','A0_'])for(let count=1;count<=32;count++)paths.add(Array.from({length:count},()=>segment).join('.'));
for(const p of ['1','0','01','-0','-0.0','+1','1e2','1E+2','1e-2','1.20','1.','1e309','9223372036854775808','-x','a.-x','_x','a-_b','a-b','a.b','A0','a.1','"a"','a"b"','""','α','中']){
 for(const w of [' ','\n','\r\n','\t','\u00a0','\ufeff']){paths.add(w+p);paths.add(p+w);paths.add(w+p+w);}
 paths.add(p);paths.add('a.'+p+'.z');
}
let seed=74931;const alphabet='abcdefXYZ019_-';
for(let i=0;i<256;i++){
 let p='';for(let j=0;j<1+i%23;j++){seed=(Math.imul(seed,1664525)+1013904223)>>>0;p+=alphabet[seed%alphabet.length];}
 paths.add(i%3?p:'a.'+p+'.z');
}
export const requests=[...paths].map(path=>({path}));
