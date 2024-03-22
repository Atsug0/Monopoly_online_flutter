
//Récupération des informations d'un joueur ou plusieurs
//Modification des informations d'un joueur ou plusieurs
//Supprimer un joueur ou plusieurs
//Récupération des cartes
//Creation de carte temporaire
//Récupération des cartes temporaires
//Modification de carte temporaire
//Suppression de carte temporaire
//Recuperer une carte chance
//Recuperer une carte communaute


const express = require('express');
const db = require('./dbconfig');
const bcrypt = require('bcrypt');

const router = express.Router();

router.post('/registeruser', (req, res) => {
  const { username, email, password } = req.body;

  // Générer un sel et hacher le mot de passe
  bcrypt.hash(password, 10, (err, hash) => {
    if (err) {
      return res.status(500).send("Erreur lors de la génération du mot de passe haché");
    }
    const sqlQuery = `CALL registerUser(?,?,?)`;
    db.query(sqlQuery, [username, email, hash], (err, results) => {
      if (err) {
        return res.status(500).send("Erreur lors de la création de l'utilisateur");
      }
      res.status(200).send("Utilisateur créé !");
    });
  });
});

// Authentifier un utilisateur
router.post('/authenticateuser', (req, res) => {
  const { input, password } = req.body;
  const sqlQuery = `CALL authenticateUser(?)`;
  db.query(sqlQuery, [input], (err, results) => {
    if (err) {
        console.log(err);
      return res.status(500).send("Authentification échouée");
    }
    if (results.length === 0) {
        console.log("Utilisateur non trouvé");
      return res.status(404).send("Utilisateur non trouvé");
    }
    const user = results[0];
    // Vérifier le mot de passe
    bcrypt.compare(password, user[0].password, (err, result) => {
      if (err) {
        console.log("Erreur lors de la comparaison du mot de passe");
        return res.status(500).send("Erreur lors de la comparaison du mot de passe");
      }
      if (!result) {
        console.log("Mot de passe incorrect");
        return res.status(401).send("Mot de passe incorrect");
      }
      console.log("Mot de passe incorrect");
      res.status(200).send("Authentification réussie !");
    });
  });
});
router.get('/getjoueurwithid', (req, res) => {
    const sqlQuery = `CALL getJoueur(?)`;
    const id_params = req.query.id;
    db.query(sqlQuery,[id_params],(err,results)=>{
        if (err) throw err;
        res.status(200).send(results);
    });
});
router.put('/updatejoueur', (req, res) => {
  const sqlQuery = `CALL updateJoueur(?,?,?,?,?,?,?,?)`;
  const {user_id, argent, couleur, lst_biens, lst_cartes, prison, position} = req.body;
  db.query(sqlQuery,[user_id,argent,couleur,lst_biens,lst_cartes,prison,position],(err,results)=>{
      if (err) throw err;
      res.status(200).send("Joueur created !");
  });
});
router.get('/getgame', (req, res) => {  
  const sqlQuery = `CALL getgame(?)`;
  const id_params = req.query.id;
  db.query(sqlQuery,[id_params],(err,results)=>{
      if (err) throw err;
      res.status(200).send(results);
  });
});
router.put('/updategame', (req, res) => {
  const sqlQuery = `CALL updateGame(?,?,?)`;
  const {lobby_id, state, tour} = req.body;
  db.query(sqlQuery,[lobby_id,state, tour],(err,results)=>{
      if (err) throw err;
      res.status(200).send("Game updated !");
  });
});
//Creer une nouvelle partie avec l'id de l'utilisateur et le nb de joueurs
router.post('/creategame', (req, res) => {
    const sqlQuery = `CALL createGame(?,?,?,?,?,?,?,?,?)`;
    const sqlQuery2 = `CALL createJoueur(?,?,?,?,?,?,?,?)`;
    const { lobby_id, user_id,nb_joueurs,lst_joueurs,state,tour } = req.body;
    const {j1,j2,j3,j4} = lst_joueurs;
    const argent = 1500;
    const prison = false;
    const position = 0;
    const couleur=["red","blue","green","yellow"];
    const biens="";
    const cartes="";
    i=0;
    lst_joueurs.forEach(joueur => {
      db.query(sqlQuery2,[joueur,argent,couleur[i],biens,cartes,prison,position],(err,results)=>{
        if (err) throw err;
      });
      i=i+1;
    });
    db.query(sqlQuery,[lobby_id,user_id,nb_joueurs,j1,j2,j3,j4,state,tour],(err,results)=>{
        if (err) throw err;
        res.status(200).send("Lobby created !");
    });
  });
 
// get username avec son id
router.get('/getinfosuserwithid', (req, res) => {
    const id_params = req.query.id;
    db.query(`SELECT * FROM users WHERE user_id=${id_params}`, (err, results) => {
      if (err) {
        return res.status(500).send("Internal Server Error ! ");
      }
      const user = results[0];
      if (!user) {
        return res.status(404).send("User not found ! ");
      }
        res.status(200).json({username: user.username });
      });
  });

  module.exports = router;