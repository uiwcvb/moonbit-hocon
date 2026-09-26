// Consumes the actual upstream controller fragment, not a running controller.
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {Config} from '../tools/config.mjs';
const root=fileURLToPath(new URL('./openwhisk/',import.meta.url));
const config=Config.loadFile(path.join(root,'controller/application.conf'),{
  fallbackFiles:[path.join(root,'controller/reference.conf')],
  classpath:[path.join(root,'resources')],network:false,environment:{}
});
// Typed access is evaluated by the retained MoonBit configuration tree.
const startup={
  port:config.getInt('pekko.http.server.default-http-port'),
  bindHost:config.getString('pekko.http.server.bind-host'),
  requestTimeoutNanoseconds:config.getDuration('pekko.http.server.request-timeout'),
  idleTimeoutNanoseconds:config.getDuration('pekko.http.server.idle-timeout'),
  maxContentBytes:config.getBytes('pekko.http.server.parsing.max-content-length'),
  statistics:config.getBoolean('pekko.http.server.stats-support'),
  headHandling:config.getBoolean('pekko.http.server.transparent-head-requests'),
  version:config.getString('pekko.http.version'),
  protocol:config.getString('whisk.controller.protocol'),
  logLevel:config.getString('pekko.loglevel'),
  enabledProtocols:config.getStringList('ssl-config.enabledProtocols')
};
console.log(JSON.stringify({scope:'OpenWhisk controller configuration fragment; no application startup',startup},null,2));
