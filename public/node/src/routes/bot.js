const express = require('express');
const router = express.Router();
const venom = require('venom-bot');
const fs = require('fs');
const axios = require('axios');



router.post('/:id', (req, res, next) =>{
    console.log('estou aqui');
    var id = req.params.id;
    res.status(201).send({
        resposta: "sessão iniciada para" + id
    }); 

    venom.create(`${id}`, (base64Qr, asciiQR) => {        
        console.log(asciiQR); 
        exportQR(base64Qr, `src/qr/${id}-qr.png`);
      }).then((client) => {
        start(client);
      });

    function exportQR(qrCode, path) {
    qrCode = qrCode.replace('data:image/png;base64,', '');
    const imageBuffer = Buffer.from(qrCode, 'base64');    
    
    fs.writeFileSync(path, imageBuffer);    
    }

    function start(client) {
    client.onMessage((message) => {
        axios.post('http://localhost:3002/bot/conversation', {empresa: message}).then(function(response){
            console.log(response.data);
            client.sendText(message.from, response.data);
        });        
    });
    }
});

router.put('/:id', (req, res, next) =>{
    var fone = req.params.id;
    console.log(req.params)
    res.status(201).send({
        resposta: "sessão iniciada para " + fone
    }); 
    
    venom.create('128').then((client) => sendmessage(client));

    function sendmessage(client) {
        client.onMessage(() => {
            
            client.sendText(fone, 'olá');
           
        });
    }
});

module.exports = router;



  