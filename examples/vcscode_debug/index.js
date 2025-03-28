const http = require('http');

const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('🚀 Servidor Node.js puro rodando com sucesso!');
});

server.listen(port, hostname, () => {
    console.log(`✅ Servidor rodando em http://${hostname}:${port}/`);
});
