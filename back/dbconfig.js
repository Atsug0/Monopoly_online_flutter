const mysql = require('mysql');
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'monop'
});
db.query(`CREATE DATABASE IF NOT EXISTS monop;`);
db.query(`USE monop;`);
db.query(`
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
db.query(`
CREATE TABLE IF NOT EXISTS parties (
    id INTEGER PRIMARY KEY,
    nombreDeJoueur INTEGER,
    listeJoueur TEXT,
    state BOOLEAN,
    tour INTEGER
);`);
db.query(`
CREATE TABLE IF NOT EXISTS joueurs (
    id INTEGER PRIMARY KEY,
    reference TEXT,
    argent INTEGER,
    couleur TEXT,
    biens TEXT,
    cartes TEXT,
    prison BOOLEAN,
    position INTEGER
);`); 
db.query(`
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
db.query(`
-- Enregistrez un nouvel utilisateur :
DELIMITER //

CREATE PROCEDURE registerUser(
    username_u VARCHAR(255),
    email_u VARCHAR(255),
    password_u VARCHAR(255)
)
BEGIN
    IF EXISTS (SELECT 1 FROM User WHERE email = email_u) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cette adresse e-mail est déjà utilisée';
    ELSEIF EXISTS (SELECT 1 FROM User WHERE username = username_u) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ce nom d\'utilisateur est déjà utilisé';
    ELSE
        INSERT INTO User (
            username,
            email,
            password
        ) VALUES (
            username_i,
            adresse_mail_i,
            mot_de_passe_i
        );
    END IF;
END //

DELIMITER ;
`);
db.query(`-- Authentifier un utilisateur :

DELIMITER //

CREATE PROCEDURE authenticateUser(
    input VARCHAR(255),
    mot_de_passe1 VARCHAR(255)
)
BEGIN
    -- Vérification des identifiants
    IF EXISTS (SELECT 1 FROM User WHERE adresse_mail = input AND mot_de_passe = mot_de_passe1) THEN
        SELECT 'Authentification réussie' AS message;
    ELSE
        IF EXISTS (SELECT 1 FROM User WHERE username = input AND mot_de_passe = mot_de_passe1) THEN
            SELECT 'Authentification réussie' AS message;
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Identifiants incorrects';
        END IF;
    END IF;
END //

DELIMITER ;
`);	

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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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
        -1,
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

lstCarte.forEach((carte) => {
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
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
        );
    `, [
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

module.exports = db;
