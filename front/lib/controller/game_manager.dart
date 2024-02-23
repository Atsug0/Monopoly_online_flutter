import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';

class GameManager {
  static GameManager cardManager = GameManager();
  late List<Carte> lstCarte;
  late List<Joueur> lstJoueur;

  void init() {
    lstJoueur = [
      Joueur(
          id: 0,
          argent: 1500,
          couleur: "Red",
          biens: [],
          cartes: [],
          prison: false,
          position: 0, reference: ''),
      Joueur(
          id: 1,
          argent: 1500,
          couleur: "Blue",
          biens: [1],
          cartes: [0, 1, 3],
          prison: false,
          position: 0, reference: ''),
      Joueur(
          id: 2,
          argent: 1500,
          couleur: "Green",
          biens: [3],
          cartes: [0, 1, 3],
          prison: false,
          position: 2, reference: ''),
      Joueur(
          id: 3,
          argent: 1500,
          couleur: "Yellow",
          biens: [2],
          cartes: [],
          prison: false,
          position: 3, reference: ''),
    ];
    lstCarte = [
      Carte(
          nom: "DEPART",
          prix: 0,
          couleur: "Black",
          position: 0,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: true,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "BOULEVARD DE BELLEVILLE",
          prix: 60,
          couleur: "SaddleBrown",
          position: 1,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "CAISSE DE COMMUNAUTE",
          prix: 0,
          couleur: "Black",
          position: 2,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: true,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "RUE LECOURBE",
          prix: 60,
          couleur: "SaddleBrown",
          position: 3,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "IMPOTS SUR LE REVENU",
          prix: -200,
          couleur: "Black",
          position: 4,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "GARE MONTPARNASSE",
          prix: 200,
          couleur: "Black",
          position: 5,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "RUE DE VAUGIRARD",
          prix: 100,
          couleur: "SkyBlue",
          position: 6,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Chance",
          prix: 0,
          couleur: "Black",
          position: 7,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: true,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "RUE DE COURCELLES",
          prix: 100,
          couleur: "SkyBlue",
          position: 8,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE DE LA REPUBLIQUE",
          prix: 120,
          couleur: "SkyBlue",
          position: 9,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Prison",
          prix: 0,
          couleur: "Black",
          position: 10,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: true,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "BOULEVARD DE LA VILLETTE",
          prix: 140,
          couleur: "DarkOrchid",
          position: 11,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Compagnie Electricité",
          prix: 150,
          couleur: "Black",
          position: 12,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE DE NEUILLY",
          prix: 140,
          couleur: "DarkOrchid",
          position: 13,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "RUE DE PARADIS",
          prix: 160,
          couleur: "DarkOrchid",
          position: 14,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Gare de Lyon",
          prix: 200,
          couleur: "Black",
          position: 15,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE MOZART",
          prix: 180,
          couleur: "Orange",
          position: 16,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "CAISSE DE COMMUNAUTE",
          prix: 0,
          couleur: "Black",
          position: 17,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: true,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "BOULEVARD SAINT-MICHEL",
          prix: 180,
          couleur: "Orange",
          position: 18,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "PLACE PIGALLE",
          prix: 200,
          couleur: "Orange",
          position: 19,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Parc Gratuit",
          prix: 0,
          couleur: "Black",
          position: 20,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 3800,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE MATIGNON",
          prix: 220,
          couleur: "Red",
          position: 21,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "CHANCE",
          prix: 0,
          couleur: "Black",
          position: 22,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: true,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "BOULEVARD MALESHERBES",
          prix: 220,
          couleur: "Red",
          position: 23,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE HENRI-MARTIN",
          prix: 240,
          couleur: "Red",
          position: 24,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "GARE DU NORD",
          prix: 200,
          couleur: "Black",
          position: 25,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "FAUBOURG SAINT-HONORE",
          prix: 260,
          couleur: "Yellow",
          position: 26,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "PLACE DE LA BOURSE",
          prix: 260,
          couleur: "Yellow",
          position: 27,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Compagnie EAUX",
          prix: 150,
          couleur: "Black",
          position: 28,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "RUE LA FAYETTE",
          prix: 280,
          couleur: "Yellow",
          position: 29,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "ALLEZ EN PRISON",
          prix: 0,
          couleur: "Black",
          position: 30,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: true,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE DE BRETEUIL",
          prix: 300,
          couleur: "Green",
          position: 31,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "AVENUE FOCH",
          prix: 300,
          couleur: "Green",
          position: 32,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "CAISSE DE COMMUNAUTE",
          prix: 0,
          couleur: "Black",
          position: 33,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: true,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "BOULEVARD DES CAPUCINES",
          prix: 320,
          couleur: "Green",
          position: 34,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "GARE SAINT-LAZARE",
          prix: 200,
          couleur: "Black",
          position: 35,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "Chance",
          prix: 0,
          couleur: "Black",
          position: 36,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: true,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "CHAMPS-ELYSEES",
          prix: 350,
          couleur: "Blue",
          position: 37,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "TAXE DE LUXE",
          prix: -100,
          couleur: "Black",
          position: 38,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
      Carte(
          nom: "RUE DE LA PAIX",
          prix: 400,
          couleur: "Blue",
          position: 39,
          acheteurId: -1,
          maison: 0,
          hotel: 0,
          image: "",
          chance: false,
          communaute: false,
          prison: false,
          depart: false,
          parc: 0,
          goprison: false,
          prixHotel: 18,
          prixMaison: 25),
    ];
  }

  void setCard(Carte carte) {}
  void getCards() {}
  void addHouse() {}
  void addHotels() {}
  void canHaveHouses() {}
  void canHaveHotels() {}
  String getChance() {
    return "0";
  }

  String getCommunaute() {
    return "0";
  }

  bool achetable(int id) {
    Joueur j = lstJoueur.elementAt(id);
    Carte c = lstCarte.firstWhere((element) => element.position == j.position);
    if (j.argent > c.prix) {
      return true;
    }
    return false;
  }

  bool asToPay() {
    return true;
  }

  int getIdTurn() {
    return 0;
  }

  void endTurn() {}

  void transaction(int id1, int id2, int prix) {}
  void achat(int idJoueur, int idCard, int prix) {
    lstJoueur.elementAt(idJoueur).argent -= prix;
    lstJoueur.elementAt(idJoueur).biens.add(idCard);
    //faire la modif en back
  }

  void deplacement(int idJoueur, int nbr) {
    if (lstJoueur.elementAt(idJoueur).position + nbr <= 39) {
      lstJoueur.firstWhere((element) => element.id == idJoueur).position += nbr;
    } else {
      if (lstJoueur.elementAt(idJoueur).position + nbr == 40) {
        lstJoueur.firstWhere((element) => element.id == idJoueur).position = 0;
        lstJoueur.firstWhere((element) => element.id == idJoueur).argent += 400;
      } else {
        int copie = nbr;
        while (lstJoueur.elementAt(idJoueur).position != 40) {
          lstJoueur.firstWhere((element) => element.id == idJoueur).position +=
              1;
          copie--;
        }
        lstJoueur.firstWhere((element) => element.id == idJoueur).position =
            copie;
      }
    }
    //faire l'update côté serv
  }

  int getDeplacement() {
    return 0;
  }

  int action(int id) {
    Joueur j = lstJoueur.firstWhere((element) => element.id == id);
    Carte c = lstCarte.firstWhere((element) => element.position == j.position);
    int j2 = getOwner(c);

    if (j2 != -1) {
      transaction(j.id, j2, c.prix);
      return (0); // pop up tu payes
    } else {
      if (c.chance) {
        return (1);
      }
      if (c.communaute) {
        return (2);
      }
      if (c.goprison) {
        return (3);
      }
      if (c.prison) {
        return (4);
      }
      if (c.position == 21) {
        return (5);
      }
    }
    return (6);
  }

  Color getColor(String color) {
    switch (color) {
      case "SaddleBrown":
        return const Color(0xFF8b4513);
      case "DarkOrchid":
        return const Color(0xFF9932CC);
      case "Red":
        return Colors.red;
      case "Green":
        return Colors.green;
      case "SkyBlue":
        return const Color(0xFF87CEEB);
      case "Orange":
        return Colors.orange;
      case "Yellow":
        return Colors.yellow;
      case "Blue":
        return const Color.fromARGB(255, 10, 41, 214);
      default:
        return Colors.black;
    }
  }

  Color getCardColor(Carte carte) {
    for (Joueur j in lstJoueur) {
      if (j.biens.contains(carte.position)) {
        return getColor(j.couleur).withOpacity(0.4);
      }
    }
    return Colors.white;
  }

  int getCagnote() {
    for (Carte c in lstCarte) {
      if (c.parc > 0) {
        return c.parc;
      }
    }
    return 0;
  }

  int getOwner(Carte carte) {
    for (Joueur j in lstJoueur) {
      if (j.biens.contains(carte.position)) {
        return j.id;
      }
    }
    return -1;
  }

  List<String> getListAddr(int id) {
    List<String> res = [];

    for (Carte carte in lstCarte) {
      if (lstJoueur.elementAt(id).biens.contains(carte.position)) {
        res.add(carte.nom);
      }
    }
    return res;
  }

  bool isSpecial(Carte c) {
    if (c.chance ||
        c.communaute ||
        c.prison ||
        c.goprison ||
        c.depart ||
        c.position == 20) {
      return true;
    }
    return false;
  }
}
