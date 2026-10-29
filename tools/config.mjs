import {load_json,join_path_json,split_path_json} from '../web/engine.mjs';
import {executeAsync as dispatchAsync} from './config-async.mjs';
import {prepare} from './config-host.mjs';
import {ConfigError} from './config-error.mjs';
export {ConfigError} from './config-error.mjs';
export {parseProperties} from './config-host.mjs';
export {Config,ConfigValue,ConfigObject,ConfigList,ConfigEntry,ConfigEntrySet} from './config-object.mjs';
function pathResult(text) {
  const result=JSON.parse(text);
  if(!result.accepted)throw new ConfigError(result);
  return result.value;
}
/** Convert literal keys into a canonical HOCON path expression. */
export function joinPath(parts) {
  if(!Array.isArray(parts))throw new TypeError('Path elements must be an array of strings');
  for(const part of parts)if(typeof part!=='string')throw new TypeError('Path elements must be an array of strings');
  return pathResult(join_path_json(JSON.stringify(parts)));
}
/** Decode a HOCON path expression into detached literal keys. */
export function splitPath(path) {
  if(typeof path!=='string')throw new TypeError('Configuration path must be a string');
  return pathResult(split_path_json(path));
}
function execute(source,options,kind) {
  if(options.document!==undefined&&typeof options.document!=='boolean')throw new TypeError('document must be boolean');
  if(!options.document&&(options.steps!==undefined||options.probes!==undefined))throw new TypeError('steps/probes require document: true');
  if(options.document&&['getter','path','operations','checkValid','referenceSource','validationPaths'].some(key=>options[key]!==undefined))throw new TypeError('document pipeline conflicts with resolved getters, edits or validation');
  const {request,callback}=prepare(source,options,kind);
  const result=JSON.parse(load_json(JSON.stringify(request),callback));
  if(!result.accepted)throw new ConfigError(result);
  return result.value;
}

/** Resolve a string. Includes use sourceName (if absolute) or cwd. Environment is opt-in. */
export function load(source,options={}) { return execute(source,options,'string'); }
/** Resolve an exact UTF-8 file, with per-file origins retained for all fallback files. */
export function loadFile(filename,options={}) { return execute(filename,options,'file'); }
/** Resolve an exact HTTP(S) or file URL; Content-Type can override its extension. */
export function loadURL(url,options={}) { return execute(url,options,'url'); }

function executeAsync(source,options,kind){
  return dispatchAsync(source,options,kind,result=>result.name==='ConfigError'?new ConfigError({error:result.message,position:result.position,problems:result.problems}):new Error(result.message));
}

/** Async variants keep the calling event loop responsive and accept AbortSignal. */
export function loadAsync(source,options={}){return executeAsync(source,options,'string');}
export function loadFileAsync(filename,options={}){return executeAsync(filename,options,'file');}
export function loadURLAsync(url,options={}){return executeAsync(url,options,'url');}
