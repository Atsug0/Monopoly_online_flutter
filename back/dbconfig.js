const e = require('cors');
const mysql = require('mysql');
const db = mysql.createConnection({
    host: 'localhost',
    user: 'roots',
    password: 'roots',
    
});

function executedbc() { 
// Établir la connexion à la base de données
db.connect((err) => {
    if (err) {
      console.error('Erreur de connexion à la base de données : ' + err.stack);
      return;
    }
    console.log('Connecté à la base de données MySQL');
  });
  
db.query(`CREATE DATABASE IF NOT EXISTS monop;`);
db.query(`USE monop;`);
db.query('DROP TABLE IF EXISTS cartes;');
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
db.query(` -- Créer une table chance :
CREATE TABLE IF NOT EXISTS chance (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    description TEXT
);`);
db.query(` -- Créer une table communaute :
CREATE TABLE IF NOT EXISTS communaute (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    description TEXT
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
db.query(` -- Créer une table d'utilisateurs :
CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    token TEXT,
    username TEXT,
    email TEXT,
    password TEXT,
    partieGagne INTEGER,
    parties INTEGER,
    argentTotal INTEGER
);
`);
db.query(` -- Mettre à jour une carte avec id :
CREATE PROCEDURE IF NOT EXISTS updatecarte(
    carte_ids INTEGER,
    acheteur_new INTEGER,
    maison_new INTEGER,
    hotel_new INTEGER,
    parc_new INTEGER
  )
  BEGIN
    UPDATE cartes
    SET
      acheteur_id = COALESCE(acheteur_new, acheteur_id),  
      maison = COALESCE(maison_new, maison),           
      hotel = COALESCE(hotel_new, hotel),              
      parc = COALESCE(parc_new, parc)                   
    WHERE id = carte_ids;
END;
`);

db.query(`-- Getinfosuserwithid :
CREATE PROCEDURE IF NOT EXISTS getinfosuserwithid(
    id_test INTEGER
)
BEGIN
    SELECT * FROM users WHERE id = id_test;
END ;
`);
db.query(`-- Enregistrez un nouvel utilisateur :
CREATE PROCEDURE IF NOT EXISTS registerUser(
    username_u VARCHAR(255),
    email_u VARCHAR(255),
    password_u VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE email = email_u) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cette adresse e-mail est déjà utilisée';
    ELSEIF EXISTS (SELECT 1 FROM users WHERE username = username_u) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ce nom d utilisateur est déjà utilisé';
    ELSE
        INSERT INTO users (
            username,
            email,
            password,
            partieGagne,
            parties,
            argentTotal
        ) VALUES (
            username_u,
            email_u,
            password_u,
            0,
            0,
            0
        );
    END IF;
END ;


`);
db.query(`-- Authentifier un utilisateur :



CREATE PROCEDURE IF NOT EXISTS authenticateUser(
    IN input VARCHAR(255)
  )
  BEGIN
    -- Verification of credentials
    DECLARE user_hashpass VARCHAR(255);
    DECLARE user_id INTEGER;
    SELECT password, id INTO user_hashpass, user_id  
    FROM users
    WHERE email = input OR username = input;
    IF user_hashpass IS NOT NULL THEN
      SELECT user_id AS id, 'User trouvé' AS message, user_hashpass AS password;  
    ELSE
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Utilisateur non trouvé';
    END IF;
  END ;
`);	
db.query(`-- Créer une nouvelle partie :

CREATE PROCEDURE IF NOT EXISTS createGame(
    id INTEGER,
    user_id INTEGER,
    nombreDeJoueur INTEGER,
    j1 INTEGER,
    j2 INTEGER,
    j3 INTEGER,
    j4 INTEGER,
    tour INTEGER,
    state BOOLEAN
)
BEGIN
    INSERT INTO parties (
        id,
        user_id,
        nombreDeJoueur,
        j1,
        j2,
        j3,
        j4,
        tour,
        state
    ) VALUES (
        id,
        user_id,
        nombreDeJoueur,
        j1,
        j2,
        j3,
        j4,
        tour,
        state
    );
END ;
`);
db.query(`--  Mettre à jour une partie :
CREATE PROCEDURE IF NOT EXISTS updateGame(
    ids INTEGER,
    state BOOLEAN,
    tour INTEGER
)
BEGIN
    UPDATE parties
    SET
        state = state,
        tour = tour
    WHERE id = ids;
END ;
`);
db.query(`-- Get Partie avec id  :   
CREATE PROCEDURE IF NOT EXISTS getgame(
    id_new INTEGER
)
BEGIN
    SELECT * FROM parties WHERE id = id_new;
END ;
`);

db.query(`-- Initialiser les joueurs :
CREATE PROCEDURE IF NOT EXISTS createJoueur(
    user_id INTEGER,
    argent INTEGER,
    couleur TEXT,
    biens TEXT,
    cartes TEXT,
    prison BOOLEAN,
    position INTEGER
)
BEGIN
    INSERT INTO joueurs (
        user_id,
        argent,
        couleur,
        biens,
        cartes,
        prison,
        position
    ) VALUES (
        user_id,
        argent,
        couleur,
        biens,
        cartes,
        prison,
        position
    );
END ;
`);
db.query(`-- Mettre à jour un user :
CREATE PROCEDURE IF NOT EXISTS updateuser(
    user_id INTEGER,
    new_partieGagne INTEGER,
    new_parties INTEGER,
    new_argent INTEGER
)
BEGIN
    UPDATE users
    SET
        partieGagne = COALESCE((new_partieGagne + partieGagne), new_partieGagne),
        parties = COALESCE((new_parties + parties), new_parties),
        argentTotal = COALESCE((new_argent + argentTotal), new_argent) 
    WHERE id = user_id;
END ;
`);

db.query(`-- Mettre à jour un joueur :
CREATE PROCEDURE IF NOT EXISTS updatejoueur(
    new_cid INTEGER,
    new_argent INTEGER,
    new_couleur TEXT,
    new_biens TEXT,
    new_cartes TEXT,
    new_prison BOOLEAN,
    new_position INTEGER
)
BEGIN
    UPDATE joueurs
    SET
        argent = COALESCE(new_argent, argent),
        couleur = COALESCE(new_couleur, couleur),
        biens = COALESCE(new_biens, biens),
        cartes = COALESCE(new_cartes, cartes),
        prison = COALESCE(new_prison, prison),
        position = COALESCE(new_position, position)
    WHERE user_id = new_cid;
END ;`);
db.query(`-- Get carte communaute :
CREATE PROCEDURE IF NOT EXISTS getcommunaute()
BEGIN
    SELECT description FROM communaute 
    WHERE id = RAND() * (SELECT MAX(id) FROM communaute);
    END ;
`);
db.query(`-- Get carte chance :
CREATE PROCEDURE IF NOT EXISTS getchance()
BEGIN
    SELECT description FROM chance 
    WHERE id = RAND() * (SELECT MAX(id) FROM chance);
    END ;
`);
const lst_chances = [
    "Rendez-vous rue de la Paix",
    "Avancez jusqu'à la case Départ",
    "Rendez-vous à l'avenue Henri-Martin, si vous passez par la case Départ, recevez 200€",
    "Avancez au Boulevard de la Villette, si vous passez par la case Départ, recevez 200€",
    "Vous êtes imposé pour les réparations de voirie à raison de 40€ par maison et 115€ par hôtel",
    "Avancez jusqu'à la case Gare de Lyon, si vous passez par la case Départ, recevez 200€",
    "Vous avez gagné le prix de mots croisés, recevez 100€",
    "La banque vous verse un dividende de 50€",
    "Vous êtes libéré de prison, cette carte peut être conservée jusqu'à ce qu'elle soit utilisée ou vendue",
    "Reculez de trois cases",
    "Allez en prison. Rendez-vous directement en prison, ne passez pas par la case Départ, ne recevez pas 200€",
    "Faîtes des réparations dans toutes vos maisons, 25€ par maison, 100€ par hôtel",
    "Amende pour excès de vitesse, 15€",
    "Payez pour frais de scolarité, 150€",
    "Amende pour ivresse, 20€",
    "Votre immeuble et votre prêt rapportent, vous devez toucher 150€"
];
const lst_communautes = [
    "Placez-vous sur la case Départ",
    "Erreur de la banque en votre faveur, recevez 200€",
    "Payez la note du médecin, 50€",
    "La vente de votre stock vous rapporte 50€",
    "Vous êtes libéré de prison, cette carte peut être conservée jusqu'à ce qu'elle soit utilisée ou vendue",
    "Allez en prison. Rendez-vous directement en prison, ne passez pas par la case Départ, ne recevez pas 200€",
    "Retournez à Belleville",
    "Recevez votre revenu annuel, 100€",
    "C'est votre anniversaire, chaque joueur doit vous donner 10€",
    "Les contributions vous remboursent la somme de 20€",
    "Recevez votre intérêt sur l'emprunt à 7%, 25€",
    "Payez la police d'assurance s'élevant à 50€",
    "Payez une amende de 10€ ou tirez une carte Chance",
    "Rendez-vous à la gare la plus proche. Si vous passez par la case Départ, recevez 200€",
    "Vous avez gagné le deuxième prix de beauté, recevez 10€",
    "Vous héritez de 100€"
];
db.query(`INSERT INTO chance (description) VALUES ?`, [lst_chances.map(chance => [chance])]);
db.query(`INSERT INTO communaute (description) VALUES ?`, [lst_communautes.map(communaute => [communaute])]);
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
}
executedbc();
module.exports = db;
