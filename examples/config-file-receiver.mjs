import fs from 'node:fs';
import http from 'node:http';
import path from 'node:path';
import {fileURLToPath} from 'node:url';

/** A file-only application. It has no HOCON, source-config or query dependency. */
export async function startConfigFileReceiver(file) {
  const settings = JSON.parse(fs.readFileSync(file, 'utf8'));
  const keys = ['listenPort', 'enabled', 'banner', 'deploymentId'];
  if (settings === null || typeof settings !== 'object' || Array.isArray(settings) ||
      Object.keys(settings).length !== keys.length || keys.some(k => !Object.hasOwn(settings, k)) ||
      !Number.isInteger(settings.listenPort) || settings.listenPort < 0 || settings.listenPort > 65535 ||
      typeof settings.enabled !== 'boolean' || typeof settings.banner !== 'string' ||
      typeof settings.deploymentId !== 'string' || !/^-?(0|[1-9][0-9]*)$/.test(settings.deploymentId)) {
    throw new Error('Invalid settings file');
  }
  const body = JSON.stringify({configuredPort: settings.listenPort, enabled: settings.enabled,
    banner: settings.banner, deploymentId: settings.deploymentId});
  const server = http.createServer((_request, response) => {
    response.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
    response.end(body);
  });
  await new Promise((resolve, reject) => {
    server.once('error', reject);
    server.listen(settings.listenPort, '127.0.0.1', resolve);
  });
  return {server, url: 'http://127.0.0.1:' + server.address().port + '/'};
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  try {
    if (process.argv.length !== 3) throw new Error('Expected one settings file');
    const {server, url} = await startConfigFileReceiver(process.argv[2]);
    process.stdout.write(JSON.stringify({ready: true, url}) + '\n');
    process.on('SIGTERM', () => server.close());
    process.on('SIGINT', () => server.close());
  } catch {
    process.stderr.write(JSON.stringify({ready: false, error: 'Settings receiver failed'}) + '\n');
    process.exitCode = 1;
  }
}
