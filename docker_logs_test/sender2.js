const http = require('http');

const SERVER_HOST = 'server';  // This should match the container name or service name
const SERVER_PORT = 3001;

const sendMessage = () => {
  setInterval(() => {
    const message = 'This is a continuous message from the sender.';
    const req = http.request({
      hostname: SERVER_HOST,
      port: SERVER_PORT,
      path: '/',
      method: 'POST',
    }, (res) => {
      res.setEncoding('utf8');
      res.on('data', (chunk) => {
        console.log('Response: ' + chunk);
      });
    });

    req.on('error', (e) => {
      console.error(`Problem with request: ${e.message}`);
    });

    req.write(message);
    req.end();
  }, 5000); // Send message every 5 seconds
};

sendMessage();

