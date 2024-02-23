// serveur.js
const express = require('express');
const db = require('./db_config');
const routes = require('./routes'); 
const cors = require('cors');
const app = express();
app.use(express.json())


app.use(cors())

// Établir la connexion à la base de données
db.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données : ' + err.stack);
    return;
  }
  console.log('Connecté à la base de données MySQL');
});

app.use('/api', routes);

// Port sur lequel le serveur Express écoutera
const port = 5000;

// Démarrer le serveur Express
app.listen(port, () => {
  console.log('Serveur Express en cours d\'écoute sur le port ' + port);
});
