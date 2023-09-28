const http = require('http');

const PORT = 3002;

const server = http.createServer((req, res) => {
  if (req.method === 'POST' && req.url === '/') {
    let body = '';

    req.on('data', (chunk) => {
      body += chunk;
    });

    req.on('end', () => {
      console.log('Received message:', body);
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/plain');
      res.end('Message received by the server\n');
    });
  } else {
    res.statusCode = 404;
    res.end('Not Found\n');
  }
});

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}/`);
});

