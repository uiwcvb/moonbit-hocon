export class ConfigError extends Error {
  constructor(result) { super(result.error); this.name='ConfigError'; this.position=result.position; this.problems=result.problems; }
}
