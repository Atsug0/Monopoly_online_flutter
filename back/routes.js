
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
      res.status(500).send("Authentification failed")
    }else{
    res.status(200).send(results);
    }
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