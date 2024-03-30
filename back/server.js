// serveur.js
const express = require('express');
const db = require('./dbconfig');
const http = require('http');
const socketIo = require('socket.io');
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
const PORT = 8008;

const server = http.createServer(app);
const io = socketIo(server);

let connectedPlayers = [];

io.on('connection', socket => {
    console.log('New client connected');
    
    // Créer une partie
    socket.on('createGame', playerId => {
      const gameId = generateGameId();
      socket.join(gameId);
      connectedPlayers.push({ gameId, playerId });
      io.to(gameId).emit('playersList', connectedPlayers.filter(player => player.gameId === gameId));
    });
    
    // Rejoindre une partie
    socket.on('joinGame', (gameId, playerId) => {
        const isGameValid = connectedPlayers.some(player => player.gameId === gameId);
        if (isGameValid) {
            if (connectedPlayers.filter(player => player.gameId === gameId).length < 4) {
                socket.join(gameId);
                connectedPlayers.push({ gameId, playerId });
                io.to(gameId).emit('playersList', connectedPlayers.filter(player => player.gameId === gameId));
            } else {
                // Emit un événement d'erreur si le nombre maximal de joueurs est atteint
                socket.emit('errorRoom', 'Maximum number of players reached for this game');
            }
        } else {
          // Emit un événement d'erreur si le gameId n'est pas valide
          socket.emit('errorRoom', 'Game ID is not valid');
        }
    });

    socket.on('addBot', (gameId, playerId) => {
        const isGameValid = connectedPlayers.some(player => player.gameId === gameId);
        if (isGameValid) {
            if (connectedPlayers.filter(player => player.gameId === gameId).length < 4) {
                connectedPlayers.push({ gameId, playerId });
                io.to(gameId).emit('playersList', connectedPlayers.filter(player => player.gameId === gameId));
            } else {
                // Emit un événement d'erreur si le nombre maximal de joueurs est atteint
                socket.emit('errorRoom', 'Maximum number of players reached for this game');
            }
        } else {
          // Emit un événement d'erreur si le gameId n'est pas valide
          socket.emit('errorRoom', 'Game ID is not valid');
        }
    });

    socket.on('deleteBot', (gameId, playerId) => {
        const isGameValid = connectedPlayers.some(player => player.gameId === gameId);
        if (isGameValid) {
            if (connectedPlayers.filter(player => player.gameId === gameId).length > 0) {
                const existingPlayerIndex = connectedPlayers.findIndex(player => player.playerId === playerId);
                if (existingPlayerIndex !== -1) {
                    connectedPlayers.splice(existingPlayerIndex, 1);
                }
                io.to(gameId).emit('playersList', connectedPlayers.filter(player => player.gameId === gameId));
            } else {
                // Emit un événement d'erreur si le nombre maximal de joueurs est atteint
                socket.emit('errorRoom', 'Pas assez de joueur');
            }
        } else {
          // Emit un événement d'erreur si le gameId n'est pas valide
          socket.emit('errorRoom', 'Game ID is not valid');
        }
    });
    
    // Lancer la partie
    socket.on('startGame', (gameId, gamenumber) => {
        io.to(gameId).emit('gamestate', gamenumber);
      io.to(gameId).emit('gameStarted');
    });
    
    // Mise à jour des données
    socket.on('updateData', (gameId) => {
      io.to(gameId).emit('dataUpdate');
    });
    
    // Fin de partie
    socket.on('endGame', gameId => {
      io.to(gameId).emit('gameEnded');
    });
    
    socket.on('disconnect', () => {
      console.log('Client disconnected');
      // Supprimer le joueur déconnecté de la liste des joueurs connectés
      connectedPlayers = connectedPlayers.filter(player => player.socketId !== socket.id);
    });
  });

// Démarrer le serveur Express
server.listen(PORT, () => {
    const address = server.address();
    console.log(`Serveur socket.io en cours d'écoute sur ${address.address}:${address.port}`);
  });

app.listen(port, () => {
  console.log('Serveur Express en cours d\'écoute sur le port ' + port);

});

function generateGameId() {
    return Math.random().toString(36).substring(2, 10); // Génère un identifiant aléatoire
  }
