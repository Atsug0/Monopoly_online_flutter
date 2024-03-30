import 'dart:js_interop';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/socket.controller.dart';
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';

class GameManager {
  static GameManager cardManager = GameManager();
  late List<Carte> lstCarte;
  late List<Joueur> lstJoueur;

  Future<void> init() async {
    await JsManager.jsmanager.getjoueurs();
    await JsManager.jsmanager.getcartes();
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

  void endTurn() {
    for (Carte c in lstCarte) {
      JsManager.jsmanager.updatecartes(c);
    }
    for (Joueur j in lstJoueur) {
      JsManager.jsmanager.updatejoueur(j);
    }
    SocketManager.socketmanager.updateData(SocketManager.socketmanager.idgame ?? "");
  }

  void transaction(int id1, int id2, int prix) {}

  void achat(int idJoueur, int idCard, int prix) {
    lstJoueur.elementAt(idJoueur).argent -= prix;
    lstJoueur.elementAt(idJoueur).biens.add(idCard);
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
  }

  int action(int id) {
    Joueur j = lstJoueur.firstWhere((element) => element.id == id);
    Carte c = lstCarte.firstWhere((element) => element.position == j.position);
    int j2 = getOwner(c);

    if (j2 != -1) {
      transaction(j.id, j2, c.prix);
      return (0);
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
