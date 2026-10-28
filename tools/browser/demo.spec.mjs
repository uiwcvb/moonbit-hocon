import { test as base, expect } from '@playwright/test';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import { createServer } from 'node:http';
import { fileURLToPath } from 'node:url';
import {
  exampleSource, exampleFields, typedSource, typedFields,
  invalidSource, invalidDiagnostic, unicodeInvalidSource, unicodeInvalidDiagnostic,
} from './fixtures.mjs';

const repo = new URL('../../', import.meta.url);
const sha256 = bytes => createHash('sha256').update(bytes).digest('hex');
let server;
let pageURL;
let compiledEngineSHA256;

base.beforeAll(async () => {
  const compiled = await readFile(new URL('_build/js/debug/build/cmd/web/web.js', repo));
  compiledEngineSHA256 = sha256(compiled);
  const assets = new Map();
  for (const name of ['index.html', 'app.mjs', 'config.mjs', 'engine.mjs']) {
    assets.set(`/web/${name}`, await readFile(new URL(`web/${name}`, repo)));
  }
  expect(sha256(assets.get('/web/engine.mjs')), 'Copy the fresh JS build to web/engine.mjs before testing')
    .toBe(compiledEngineSHA256);

  // Serve the real public assets, without mocks or a pre-existing server.
  server = createServer((request, response) => {
    const path = new URL(request.url, 'http://127.0.0.1').pathname;
    if (path === '/favicon.ico') {
      response.writeHead(204).end();
      return;
    }
    const key = path === '/web/' ? '/web/index.html' : path;
    const body = assets.get(key);
    if (!body) {
      response.writeHead(404).end();
      return;
    }
    response.writeHead(200, {
      'Content-Type': key.endsWith('.html') ? 'text/html; charset=utf-8' : 'text/javascript; charset=utf-8',
      'Cache-Control': 'no-store',
    }).end(body);
  });
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  pageURL = `http://127.0.0.1:${server.address().port}/web/`;
});

base.afterAll(async () => {
  if (server) await new Promise(resolve => server.close(resolve));
});

const test = base.extend({
  demo: async ({ page, browser }, use, testInfo) => {
    const runtimeErrors = [];
    page.on('pageerror', error => runtimeErrors.push(String(error)));
    page.on('console', message => {
      if (message.type() === 'error') runtimeErrors.push(message.text());
    });
    const engineResponse = page.waitForResponse(response => new URL(response.url()).pathname === '/web/engine.mjs');
    await page.goto(pageURL);
    const response = await engineResponse;
    expect(response.status()).toBe(200);
    const servedEngineSHA256 = sha256(await response.body());
    expect(servedEngineSHA256).toBe(compiledEngineSHA256);

    const demo = {
      input: page.getByLabel('输入', { exact: true }),
      run: page.getByRole('button', { name: '运行实际 MoonBit 代码', exact: true }),
      reset: page.getByRole('button', { name: '恢复示例', exact: true }),
      output: page.locator('#output'),
      status: page.locator('#status'),
    };
    await expect(demo.output).not.toBeEmpty();
    await use(demo);
    expect(runtimeErrors).toEqual([]);
    await testInfo.attach('browser-execution', {
      body: JSON.stringify({
        browserVersion: browser.version(),
        nodeVersion: process.version,
        compiledEngine: fileURLToPath(new URL('_build/js/debug/build/cmd/web/web.js', repo)),
        compiledEngineSHA256,
        servedEngineSHA256,
        runtimeErrors,
      }, null, 2),
      contentType: 'application/json',
    });
    await testInfo.attach('displayed-output', {
      body: await demo.output.textContent(), contentType: 'text/plain',
    });
    await testInfo.attach('rendered-page', {
      body: await page.screenshot({ fullPage: true }), contentType: 'image/png',
    });
  },
});

async function expectSuccess(demo, fields) {
  await expect(demo.output).not.toHaveClass('error');
  await expect(demo.output).not.toContainText('ERROR:');
  for (const field of fields) await expect(demo.output).toContainText(field);
  await expect(demo.status).toHaveText(/^执行 \d+\.\d{2} ms$/);
}

test('default example runs with the replaced port and resolved endpoint', async ({ demo }) => {
  await expect(demo.input).toHaveValue(exampleSource);
  await expectSuccess(demo, exampleFields);
});

test('Run displays exact values and types, including a large integer and mixed list', async ({ demo }) => {
  await demo.input.fill(typedSource);
  await demo.run.click();
  await expectSuccess(demo, typedFields);
});

test('invalid input reports its location, then Run and Reset recover the page', async ({ demo }) => {
  await demo.input.fill(invalidSource);
  await demo.run.click();
  await expect(demo.output).toHaveClass('error');
  await expect(demo.output).toHaveText(invalidDiagnostic);

  await demo.input.fill('answer = 42');
  await demo.run.click();
  await expect(demo.output).toHaveText('Object({ "answer": Number("42") })');
  await expectSuccess(demo, ['"answer": Number("42")']);

  await demo.reset.click();
  await expect(demo.input).toHaveValue(exampleSource);
  await expectSuccess(demo, exampleFields);
});

test('diagnostic offsets and columns count Unicode scalars after non-BMP text', async ({ demo }) => {
  await demo.input.fill(unicodeInvalidSource);
  await demo.run.click();
  await expect(demo.output).toHaveClass('error');
  await expect(demo.output).toHaveText(unicodeInvalidDiagnostic);
});
