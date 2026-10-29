import http from 'node:http';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {Config} from '../tools/config.mjs';

/** A small application consuming original files through the public Config API. */
export async function startClasspathService({file, classpath}) {
  const config = Config.loadFile(file, {classpath, network: false, environment: {}});
  const configuredPort = config.getInt('service.port');
  if (configuredPort < 0 || configuredPort > 65535) throw new RangeError('Invalid service port');
  const response = JSON.stringify({configuredPort, label: config.getString('service.label'),
    propertiesOnly: config.getString('propertiesOnly'), confOnly: config.getString('confOnly')});
  const server = http.createServer((_request, res) => {
    res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
    res.end(response);
  });
  await new Promise((resolve, reject) => {
    server.once('error', reject);
    server.listen(configuredPort, '127.0.0.1', resolve);
  });
  return {server, url: 'http://127.0.0.1:' + server.address().port + '/'};
}

async function main(args) {
  let file;
  const classpath = [];
  try {
    for (let i = 0; i < args.length; i++) {
      if (!['--file', '--classpath'].includes(args[i]) || i + 1 >= args.length) throw new Error('Invalid startup argument');
      const name = args[i++], value = args[i];
      if (name === '--classpath') classpath.push(value);
      else { if (file !== undefined) throw new Error('Duplicate source'); file = value; }
    }
    if (file === undefined || classpath.length === 0) throw new Error('Provide file and classpath');
    const {server, url} = await startClasspathService({file, classpath});
    process.stdout.write(JSON.stringify({ready: true, url}) + '\n');
    process.on('SIGTERM', () => server.close());
    process.on('SIGINT', () => server.close());
  } catch (error) {
    process.stderr.write(JSON.stringify({ready: false, error: error.message,
      ...(error.position === undefined ? {} : {position: error.position})}) + '\n');
    process.exitCode = 1;
  }
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) await main(process.argv.slice(2));
