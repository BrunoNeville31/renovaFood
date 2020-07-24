'use strict';
const express = require('express');
const router = express.Router();
const venom = require('venom-bot');
//const controller = require('../controllers/product-controller');


const post = router.post('/:id', (req, res, next) => {    
    res.status(200).send(
        req.body
    );

});

router.delete('/:id', (req, res, next) => {    
    res.status(200).send(
        req.body
    );
});

router.put('/:id', (req, res, next) => {    
    res.status(200).send(
        req.body
    );
});


module.exports = router;