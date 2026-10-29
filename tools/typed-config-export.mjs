import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {Config, ConfigError} from './config.mjs';

const types = new Set(['string', 'boolean', 'int', 'long']);
const formats = new Set(['hocon', 'json', 'properties']);
const queryByteLimit = 400000;

export class ConfigExportError extends Error {
  constructor(message, exitCode, position) {
    super(message);
    this.name = 'ConfigExportError';
    this.exitCode = exitCode;
    if (position !== undefined) this.position = position;
  }
}

const hostError = message => new ConfigExportError(message, 1);
const object = value => value !== null && typeof value === 'object' && !Array.isArray(value);
const key = name => process.platform === 'win32' ? name.toLowerCase() : name;

function filename(value, label) {
  if (typeof value !== 'string' || value.length === 0) throw hostError(label + ' requires a file path');
  return path.resolve(value);
}

function stat(name) {
  try { return fs.statSync(name, {bigint: true}); }
  catch (error) { if (error.code === 'ENOENT') return null; throw error; }
}

// Resolve existing ancestors too: an absent destination can have a symlinked parent.
function canonical(name) {
  let current = name;
  const tail = [];
  for (;;) {
    try { return key(path.join(fs.realpathSync(current), ...tail)); }
    catch (error) {
      if (!['ENOENT', 'ENOTDIR'].includes(error.code)) throw error;
      const parent = path.dirname(current);
      if (parent === current) throw error;
      tail.unshift(path.basename(current));
      current = parent;
    }
  }
}

function protectOutput(output, inputs) {
  const destination = stat(output);
  if (destination && !destination.isFile()) throw hostError('Output must be a regular file');
  if (!destination) {
    try {
      if (fs.lstatSync(output).isSymbolicLink()) throw hostError('Output is a dangling symbolic link');
    } catch (error) { if (error.code !== 'ENOENT') throw error; }
  }
  const resolved = canonical(output);
  for (const input of inputs) {
    const source = stat(input);
    if (key(output) === key(input) || resolved === canonical(input) ||
        (destination && source && destination.dev === source.dev && destination.ino === source.ino)) {
      throw hostError('Output aliases a protected input');
    }
  }
}

function readDeclaration(file) {
  const fd = fs.openSync(file, 'r');
  let bytes;
  try {
    if (!fs.fstatSync(fd).isFile()) throw hostError('Queries must be a regular file');
    const buffer = Buffer.alloc(queryByteLimit + 1);
    let count = 0;
    while (count < buffer.length) {
      const n = fs.readSync(fd, buffer, count, buffer.length - count, null);
      if (n === 0) break;
      count += n;
    }
    if (count > queryByteLimit) throw hostError('Query file exceeds 400000 bytes');
    bytes = buffer.subarray(0, count);
  } finally { fs.closeSync(fd); }
  let declaration;
  try { declaration = JSON.parse(new TextDecoder('utf-8', {fatal: true}).decode(bytes)); }
  catch { throw hostError('Queries must be valid UTF-8 JSON'); }
  if (!object(declaration) || declaration.version !== 1 ||
      Object.keys(declaration).some(k => !['version', 'fields'].includes(k)) ||
      !Array.isArray(declaration.fields) || declaration.fields.length < 1 || declaration.fields.length > 64) {
    throw hostError('Queries require version 1 and 1..64 fields');
  }
  const names = new Set();
  return declaration.fields.map(field => {
    if (!object(field) || Object.keys(field).some(k => !['name', 'path', 'type'].includes(k)) ||
        typeof field.name !== 'string' || field.name.length === 0 ||
        typeof field.path !== 'string' || !types.has(field.type) || names.has(field.name)) {
      throw hostError('Invalid or duplicate query field');
    }
    names.add(field.name);
    return {name: field.name, path: field.path, type: field.type};
  });
}

function sourceFailure(error) {
  if (error instanceof ConfigError ||
      error.code === 'ERR_ENCODING_INVALID_ENCODED_DATA' ||
      error.message === 'Malformed properties Unicode escape') {
    return new ConfigExportError('Configuration parse or typed read failed', 2, error.position);
  }
  return hostError('Configuration file loading failed');
}

/**
 * Resolve one local file stack and deliver all declared typed fields to a JSON file.
 * Semantic failures do not touch the output. IO errors during writing may leave a
 * partial file; concurrent mutation, crash durability and locking are not provided.
 */
export function exportTypedConfigFile(options) {
  try {
    if (!object(options) || Object.keys(options).some(k => !['file', 'queries', 'output', 'format', 'fallbackFiles'].includes(k))) {
      throw hostError('Invalid export options');
    }
    const file = filename(options.file, 'file');
    const queries = filename(options.queries, 'queries');
    const output = filename(options.output, 'output');
    if (options.format !== undefined && !formats.has(options.format)) throw hostError('Unknown configuration format');
    const fallbacks = options.fallbackFiles ?? [];
    if (!Array.isArray(fallbacks)) throw hostError('fallbackFiles must be an array');
    const fallbackFiles = fallbacks.map(f => filename(f, 'fallback'));
    const protectedInputs = new Set([file, queries, ...fallbackFiles]);
    protectOutput(output, protectedInputs);
    const fields = readDeclaration(queries);
    let config;
    try {
      config = Config.loadFile(file, {
        ...(options.format === undefined ? {} : {format: options.format}),
        fallbackFiles, environment: {}, network: false,
        onRead: event => protectedInputs.add(event.path),
      });
    } catch (error) { throw sourceFailure(error); }
    const record = Object.create(null);
    for (const field of fields) {
      try { record[field.name] = config.get(field.path, {type: field.type}); }
      catch (error) { throw sourceFailure(error); }
    }
    const text = JSON.stringify(record) + '\n';
    protectOutput(output, protectedInputs);
    fs.writeFileSync(output, text, 'utf8');
    return Object.freeze({output, fields: fields.length, bytes: Buffer.byteLength(text)});
  } catch (error) {
    if (error instanceof ConfigExportError) throw error;
    throw hostError('Export filesystem operation failed');
  }
}

function main(args) {
  const options = {fallbackFiles: []};
  const names = {'--file': 'file', '--queries': 'queries', '--output': 'output', '--format': 'format'};
  try {
    for (let i = 0; i < args.length; i++) {
      const arg = args[i];
      if (arg === '--help') {
        process.stdout.write('Usage: node tools/typed-config-export.mjs --file PATH --queries JSON --output PATH [--format hocon|json|properties] [--fallback PATH ...]\nLocal files only. Queries: version 1, 1..64 unique named string/boolean/int/long fields.\nExit: 0 complete file delivery, 2 invalid configuration/typed read, 1 declaration/argument/IO error.\n');
        return;
      }
      if (!Object.hasOwn(names, arg) && arg !== '--fallback') throw hostError('Unknown export argument');
      if (i + 1 >= args.length) throw hostError('Missing export argument value');
      const value = args[++i];
      if (arg === '--fallback') options.fallbackFiles.push(value);
      else {
        const name = names[arg];
        if (options[name] !== undefined) throw hostError('Duplicate export argument');
        options[name] = value;
      }
    }
    process.stdout.write(JSON.stringify({ok: true, ...exportTypedConfigFile(options)}) + '\n');
  } catch (error) {
    const exitCode = error instanceof ConfigExportError ? error.exitCode : 1;
    process.stderr.write(JSON.stringify({ok: false, error: error.message,
      ...(error.position === undefined ? {} : {position: error.position})}) + '\n');
    process.exitCode = exitCode;
  }
}

if (process.argv[1] && key(path.resolve(process.argv[1])) === key(fileURLToPath(import.meta.url))) main(process.argv.slice(2));
