"""Preview a production web build the way Vercel serves it.

    flutter build web --release --wasm --no-web-resources-cdn
    python3 tool/serve_web.py build/web     # http://127.0.0.1:8767

Static files first, then the SPA fallback to index.html, with the same
response headers as vercel.json (keep the two in step).
"""
import http.server
import os
import sys

ROOT = sys.argv[1] if len(sys.argv) > 1 else 'build/web'
PORT = 8767
HEADERS = {
    'Cross-Origin-Opener-Policy': 'same-origin',
    'Cross-Origin-Embedder-Policy': 'require-corp',
    'X-Content-Type-Options': 'nosniff',
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    'X-Frame-Options': 'DENY',
}

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *a, **k):
        super().__init__(*a, directory=ROOT, **k)

    def end_headers(self):
        for k, v in HEADERS.items():
            self.send_header(k, v)
        super().end_headers()

    def send_head(self):
        path = self.translate_path(self.path)
        if not os.path.exists(path):
            self.path = '/index.html'  # SPA rewrite
        return super().send_head()

Handler.extensions_map['.wasm'] = 'application/wasm'
Handler.extensions_map['.mjs'] = 'text/javascript'
print(f'Serving {ROOT} on http://127.0.0.1:{PORT}')
http.server.ThreadingHTTPServer(('127.0.0.1', PORT), Handler).serve_forever()
