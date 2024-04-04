
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
const jwt = require('jsonwebtoken');
const passport = require('passport');
const { ExtractJwt } = require('passport-jwt');
const JwtStrategy = require('passport-jwt').Strategy;
const Sequelize = require('sequelize'); // Installation requise
class Carte {
  nom; 
  prix; 
  couleur; 
  id; 
  acheteurId; 
  maison; 
  hotel; 
  image; 
  chance; 
  communaute; 
  prison; 
  depart; 
  parc; 
  goprison; 
  prixHotel; 
  prixMaison;
  
  constructor(nom, prix, couleur, id, acheteurId, maison, hotel, image, chance, communaute, prison, depart, parc, goprison, prixHotel, prixMaison)
  {
      this.nom = nom;
      this.prix = prix;
      this.couleur = couleur;
      this.id = id;
      this.acheteurId = acheteurId;
      this.maison = maison;
      this.hotel = hotel;
      this.image = image;
      this.chance = chance;
      this.communaute = communaute;
      this.prison = prison;
      this.depart = depart;
      this.parc = parc;
      this.goprison = goprison;
      this.prixHotel = prixHotel;
      this.prixMaison = prixMaison;
  }
}
const lstCarte = [
  new Carte(
      "DEPART",
      0,
      "Black",
      0,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      true,
      0,
      false,
      18,
      25),
  new Carte(
      "BOULEVARD DE BELLEVILLE",
      60,
      "SaddleBrown",
      1,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "CAISSE DE COMMUNAUTE",
      0,
      "Black",
      2,
     -999,
      0,
      0,
      "",
      false,
      true,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "RUE LECOURBE",
      60,
      "SaddleBrown",
      3,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "IMPOTS SUR LE REVENU",
      -200,
      "Black",
      4,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "GARE MONTPARNASSE",
      200,
      "Black",
      5,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "RUE DE VAUGIRARD",
      100,
      "SkyBlue",
      6,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Chance",
      0,
      "Black",
      7,
     -999,
      0,
      0,
      "",
      true,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "RUE DE COURCELLES",
      100,
      "SkyBlue",
      8,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "AVENUE DE LA REPUBLIQUE",
      120,
      "SkyBlue",
      9,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Prison",
      0,
      "Black",
      10,
     -999,
      0,
      0,
      "",
      false,
      false,
      true,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "BOULEVARD DE LA VILLETTE",
      140,
      "DarkOrchid",
      11,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Compagnie Electricité",
      150,
      "Black",
      12,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "AVENUE DE NEUILLY",
      140,
      "DarkOrchid",
      13,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "RUE DE PARADIS",
      160,
      "DarkOrchid",
      14,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Gare de Lyon",
      200,
      "Black",
      15,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "AVENUE MOZART",
      180,
      "Orange",
      16,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "CAISSE DE COMMUNAUTE",
      0,
      "Black",
      17,
     -999,
      0,
      0,
      "",
      false,
      true,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "BOULEVARD SAINT-MICHEL",
      180,
      "Orange",
      18,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "PLACE PIGALLE",
      200,
      "Orange",
      19,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Parc Gratuit",
      0,
      "Black",
      20,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      3800,
      false,
      18,
      25),
  new Carte(
      "AVENUE MATIGNON",
      220,
      "Red",
      21,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "CHANCE",
      0,
      "Black",
      22,
     -999,
      0,
      0,
      "",
      true,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "BOULEVARD MALESHERBES",
      220,
      "Red",
      23,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "AVENUE HENRI-MARTIN",
      240,
      "Red",
      24,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "GARE DU NORD",
      200,
      "Black",
      25,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "FAUBOURG SAINT-HONORE",
      260,
      "Yellow",
      26,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "PLACE DE LA BOURSE",
      260,
      "Yellow",
      27,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Compagnie EAUX",
      150,
      "Black",
      28,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "RUE LA FAYETTE",
      280,
      "Yellow",
      29,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "ALLEZ EN PRISON",
      0,
      "Black",
      30,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      true,
      18,
      25),
  new Carte(
      "AVENUE DE BRETEUIL",
      300,
      "Green",
      31,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "AVENUE FOCH",
      300,
      "Green",
      32,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "CAISSE DE COMMUNAUTE",
      0,
      "Black",
      33,
     -999,
      0,
      0,
      "",
      false,
      true,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "BOULEVARD DES CAPUCINES",
      320,
      "Green",
      34,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "GARE SAINT-LAZARE",
      200,
      "Black",
      35,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "Chance",
      0,
      "Black",
      36,
     -999,
      0,
      0,
      "",
      true,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "CHAMPS-ELYSEES",
      350,
      "Blue",
      37,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "TAXE DE LUXE",
      -100,
      "Black",
      38,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
  new Carte(
      "RUE DE LA PAIX",
      400,
      "Blue",
      39,
     -999,
      0,
      0,
      "",
      false,
      false,
      false,
      false,
      0,
      false,
      18,
      25),
];

// Configuration de la connexion à MariaDB
const sequelize = new Sequelize('monop', 'roots', 'roots', {
  host: 'localhost',
  dialect: 'mysql',
 
});
const User = sequelize.define('users', {
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  username: Sequelize.STRING,
  email: Sequelize.STRING,
  password: Sequelize.STRING
},{
  timestamps: false // Exclude timestamps for this model
});
// Options de stratégie JWT
const options = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: 'jhmnp' // Clé secrète pour la signature
};

// Stratégie de validation du token
passport.use(new JwtStrategy(options, (jwtPayload, done) => {
  User.findByPk(jwtPayload.id) // Rechercher par ID primaire
    .then(user => {
      if (user) {
        return done(null, user);
      } else {
        return done(null, false);
      }
    })
    .catch(err => done(err, false));
}));

const auth = passport.authenticate('jwt', { session: false });

const router = express.Router();
router.post('/finpartie', (req, res) => {
  db.query('DROP TABLE IF EXISTS cartes;');
  db.query('DROP TABLE IF EXISTS parties;');
  db.query('DROP TABLE IF EXISTS joueurs;'); 
  db.query(` -- Créer une table de cartes :
CREATE TABLE IF NOT EXISTS cartes (
    id INTEGER PRIMARY KEY,
    nom TEXT,
    prix INTEGER,
    couleur TEXT,
    acheteur_id INTEGER ,
    maison INTEGER,
    hotel INTEGER,
    image TEXT,
    chance BOOLEAN,
    communaute BOOLEAN,
    prison BOOLEAN,
    depart BOOLEAN,
    parc INTEGER,
    goprison BOOLEAN,
    prix_hotel INTEGER,
    prix_maison INTEGER
);`); 
  db.query(` -- Créer une table de parties :
CREATE TABLE IF NOT EXISTS parties (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    nombreDeJoueur INTEGER,
    j1 TEXT,
    j2 TEXT,
    j3 TEXT,
    j4 TEXT,
    state BOOLEAN,
    tour INTEGER
);`);
db.query(` -- Créer une table de joueurs :
CREATE TABLE IF NOT EXISTS joueurs (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER ,
    argent INTEGER,
    couleur TEXT,
    biens TEXT,
    cartes TEXT,
    prison BOOLEAN,
    position INTEGER
);`); 
  lstCarte.forEach(carte => {
    db.query(`
        INSERT INTO cartes (
            id ,
            nom,
            prix,
            couleur,
            acheteur_id ,
            maison,
            hotel,
            image,
            chance,
            communaute,
            prison,
            depart,
            parc,
            goprison,
            prix_hotel,
            prix_maison
        ) VALUES (
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?
        );
    ` ,
        [
        carte.id,
        carte.nom,
        carte.prix,
        carte.couleur,
        carte.acheteurId,
        carte.maison,
        carte.hotel,
        carte.image,
        carte.chance,
        carte.communaute,
        carte.prison,
        carte.depart,
        carte.parc,
        carte.goprison,
        carte.prixHotel,
        carte.prixMaison,
    ]);
});
  res.status(200).send("Partie terminée !");
  
});

router.put('/updateuser',auth, (req, res) => {
  const sqlQuery = `CALL updateuser(?,?,?,?)`;
  const {user_id, partieGagne, parties, argentTotal} = req.body;
  db.query(sqlQuery,[user_id, partieGagne, parties, argentTotal],(err,results)=>{
      if (err) throw err;
      res.status(200).send("User updated !");
  });
});
router.get('/communaute', (req, res) => {
 
  const sqlQuery = `CALL getcommunaute()`;
  db.query(sqlQuery, (err, results) => {  
    if (err) {
      return res.status(500).send("Internal Server Error ! ");
    }
    res.status(200).send(results);
  });
});
router.get('/chance', (req, res) => {
 
  const sqlQuery = `CALL getchance()`;
  db.query(sqlQuery,  (err, results) => {  
    if (err) {
      return res.status(500).send("Internal Server Error ! ");
    }
    res.status(200).send(results);
  });
});

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
      return res.status(500).send("Authentification échouée");
    }
    if (results.length === 0) {
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
      const secretKey = 'jhmnp';
      const token = jwt.sign({ id: user[0].id }, secretKey, { expiresIn: '24h' });
      const id = user[0].id;
      res.status(200).send({
        message: "Authentification réussie !",
        id: id,
        token
      });
    });
  });
});
router.put(`/updatecartes`,auth, (req, res) => {
 
  const {carte_id,acheteur_id,maison,hotel,parc} = req.body;
  const sqlQuery = `CALL updatecarte(?,?,?,?,?)`;
  db.query(sqlQuery,[carte_id,acheteur_id,maison,hotel,parc],(err,results)=>{
    if (err) throw err;
    res.status(200).send("Carte updated !");
  });
 });

router.get(`/getcartes`,auth, (req, res) => {
  db.query(`SELECT * FROM cartes`, (err, results) => {
    if (err) {
      return res.status(500).send("Internal Server Error ! ");
    }
    res.status(200).send(results);
  });
});
router.get('/getjoueur',auth, (req, res) => {
    db.query(`SELECT * FROM joueurs`,(err,results)=>{
        if (err) {
            console.log(err);
            throw err
        };
        res.status(200).send(results);
    });
});
router.put('/updatejoueur',auth, (req, res) => {
  const sqlQuery = `CALL updateJoueur(?,?,?,?,?,?,?)`;
  const {user_id, argent, couleur, lst_biens, lst_cartes, prison, position} = req.body;
  db.query(sqlQuery,[user_id,argent,couleur,lst_biens,lst_cartes,prison,position],(err,results)=>{
      if (err) throw err;
      res.status(200).send("Joueur created !");
  });
});
router.get('/getgame',auth, (req, res) => {  
  const sqlQuery = `CALL getgame(?)`;
  const id_params = req.query.id;
  db.query(sqlQuery,[id_params],(err,results)=>{
      if (err) throw err;
      res.status(200).send(results);
  });
});
router.put('/updategame',auth, (req, res) => {
  const sqlQuery = `CALL updateGame(?,?,?)`;
  const {lobby_id, state, tour} = req.body;
  db.query(sqlQuery,[lobby_id,state, tour],(err,results)=>{
      if (err) throw err;
      res.status(200).send("Game updated !");
  });
});
//Creer une nouvelle partie avec l'id de l'utilisateur et le nb de joueurs
router.post('/creategame', auth,(req, res) => {
    const sqlQuery = `CALL createGame(?,?,?,?,?,?,?,?,?)`;
    const sqlQuery2 = `CALL createJoueur(?,?,?,?,?,?,?)`;
    const { lobby_id, user_id,nb_joueurs,lst_joueurs,state,tour } = req.body;
    let j1 = lst_joueurs[0];
    let j2 = lst_joueurs[1];
    let j3 = lst_joueurs[2];
    let j4 = lst_joueurs[3];
    
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
router.get('/getinfosuserwithid',auth, (req, res) => {
    const id_params = req.query.id;
    console.log(id_params);
    db.query(`SELECT * FROM users WHERE id=${id_params}`, (err, results) => {
      if (err) {
        console.log(err);
        return res.status(500).send("Internal Server Error ! ");
      }
      const user = results[0];
      if (!user) {
        return res.status(404).send("User not found ! ");
      }
        res.status(200).json(results);
      });
  });

  module.exports = router;