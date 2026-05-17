FROM node:20-slim

# نصب پایتون و pproxy
RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*
RUN pip3 install pproxy --break-system-packages

EXPOSE 80

# کد اصلاح شده نودجی‌اس بدون غلط املایی
CMD node -e " \
const http = require('http'); \
const { exec } = require('child_process'); \
exec('python3 -m pproxy -l http://0.0.0.0:80'); \
http.createServer((req, res) => { \
  res.writeHead(200, { 'Content-Type': 'text/plain' }); \
  res.end('OK\n'); \
}).listen(80, '0.0.0.0'); \
console.log('Server and Tunnel running...'); \
"
