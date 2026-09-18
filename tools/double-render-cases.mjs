const unique=new Set(),buffer=new ArrayBuffer(8),view=new DataView(buffer);
function add(bits){unique.add(BigInt.asIntN(64,bits).toString());}
function around(value){view.setFloat64(0,value);const bits=view.getBigUint64(0);for(const delta of [-1n,0n,1n])for(const sign of [0n,1n<<63n])add(BigInt.asUintN(64,bits+delta)^sign);}
const fractionMask=(1n<<52n)-1n;
for(let exponent=0n;exponent<2048n;exponent++)for(const fraction of [0n,1n,fractionMask])for(const sign of [0n,1n<<63n])add(sign|(exponent<<52n)|fraction);
for(let exponent=-324;exponent<=308;exponent++)around(Number('1e'+exponent));
for(let bits=1n;bits<=2048n;bits++)for(const sign of [0n,1n<<63n])add(bits|sign);
let random=0x57faeedcba876543n;
for(let i=0;i<4096;i++){random=BigInt.asUintN(64,random*6364136223846793005n+1442695040888963407n);add(random);}
for(const value of [Math.PI,Math.E,0.1,0.01,0.001,1e6,1e7,1e16,1e20,1e21,1e23,Number.MAX_VALUE,Number.MIN_VALUE,Number.EPSILON])around(value);
export const bits=[...unique];
