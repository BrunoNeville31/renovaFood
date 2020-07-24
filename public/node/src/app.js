const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const router = express.Router();

const indexRoute = require('../src/routes/index')
const productRoute = require('./routes/product')
const botRoute = require('./routes/bot')

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));


app.use('/', indexRoute);
app.use('/products', productRoute);
app.use('/whatApp', botRoute);

module.exports = app;