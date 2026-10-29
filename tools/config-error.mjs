export class ConfigError extends Error {
  constructor(result) { super(result.error); this.name='ConfigError'; this.position=result.position; this.problems=result.problems; }
  /** Explicit plain snapshot; does not change automatic Error serialization. */
  toDiagnostic() {
    const diagnostic={name:this.name,message:this.message};
    if(this.position!==undefined){const {source,offset,line,column}=this.position;diagnostic.position={source,offset,line,column};}
    if(this.problems!==undefined)diagnostic.problems=this.problems.map(({path,kind,expected,actual})=>({path,kind,expected,actual}));
    return diagnostic;
  }
}
