// serveur.js
const express = require('express');
const db = require('./dbconfig');
const routes = require('./routes'); 
const cors = require('cors');
const app = express();
app.use(express.json())

// Ajouter les en-têtes CORS
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
    res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
    next();
  });

app.use(cors())


app.use('/api', routes);

// Port sur lequel le serveur Express écoutera
const port = 8000;

// Démarrer le serveur Express
app.listen(port, () => {
  console.log('Serveur Express en cours d\'écoute sur le port ' + port);
});
