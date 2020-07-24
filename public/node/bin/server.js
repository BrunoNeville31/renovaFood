
const app = require('../src/app');
const http = require('http');
const express = require('express');

const port = 3001;
app.set('port', port)

const server = http.createServer(app);

server.listen(port);
console.log('API conectada na porta' + port);