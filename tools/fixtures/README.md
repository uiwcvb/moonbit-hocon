# Local HTTP/HTTPS fixtures

`http-cert.pem` and `http-key.pem` form a self-signed, test-only certificate/key
for localhost and 127.0.0.1. They are public fixtures, not production credentials.
The key must never be used by a production service. Test clients explicitly
trust this certificate; production TLS verification is never disabled.

The certificate is valid from 2026-09-18 through 2036-09-15. Regenerate before
expiry and rerun the independent HTTPS comparison when replacing it.
