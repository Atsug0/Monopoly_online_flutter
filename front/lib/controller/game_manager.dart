import 'dart:js_interop';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/socket.controller.dart';
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';
import 'package:monopoly/model/lobbyobj.dart';

class GameManager {
  static GameManager cardManager = GameManager();
  late List<Carte> lstCarte;
  late List<Joueur> lstJoueur;
  late LobbyObj lobby;

  Future<void> init() async {
    await JsManager.jsmanager.getjoueurs();
    await JsManager.jsmanager.getcartes();
    int lob = JsManager.jsmanager.prefs.getInt("lobby") ?? 0;
    await JsManager.jsmanager.getgame(lob);
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
    int index = lstJoueur.indexWhere((element) => element.reference == id);
    print("index4 $index");
    Joueur j = lstJoueur.elementAt(index);
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
    return lobby.tour;
  }

  void endTurn() {
    bool test = true;
    for (Carte c in lstCarte) {
      JsManager.jsmanager.updatecartes(c);
    }
    for (Joueur j in lstJoueur) {
      JsManager.jsmanager.updatejoueur(j);
      if (j.argent > 0) {
        test = false;
      }
    }
    int index = lobby.lstJoueurs.indexWhere((element) => element == lobby.tour);
    if (index + 1 < lobby.lstJoueurs.length) {
      lobby.tour = lobby.lstJoueurs[index + 1];
    } else {
      lobby.tour = lobby.lstJoueurs[0];
    }
    if (test) {
      lobby.state = false;
    }
    JsManager.jsmanager
        .updategame(int.parse(lobby.lobbyId), lobby.state, lobby.tour);
    SocketManager.socketmanager
        .updateData(SocketManager.socketmanager.idgame ?? "");
  }

  void transaction(int id1, int id2, int prix) {
    lstJoueur.firstWhere((element) => element.reference == id1).argent -= prix;
    lstJoueur.firstWhere((element) => element.reference == id2).argent += prix;
  }

  void achat(int idJoueur, int idCard, int prix) {
    int index =
        lstJoueur.indexWhere((element) => element.reference == idJoueur);
    print("index1 $index");
    lstJoueur.elementAt(index).argent -= prix;
    lstJoueur.elementAt(index).biens.add(idCard);
  }

  void deplacement(int idJoueur, int nbr) {
    int index =
        lstJoueur.indexWhere((element) => element.reference == idJoueur);
    print("index2 $index");
    if (lstJoueur.elementAt(index).position + nbr <= 39) {
      lstJoueur
          .firstWhere((element) => element.reference == idJoueur)
          .position += nbr;
    } else {
      if (lstJoueur.elementAt(index).position + nbr == 40) {
        lstJoueur
            .firstWhere((element) => element.reference == idJoueur)
            .position = 0;
        lstJoueur
            .firstWhere((element) => element.reference == idJoueur)
            .argent += 400;
      } else {
        int copie = nbr;
        while (lstJoueur.elementAt(index).position != 40) {
          lstJoueur
              .firstWhere((element) => element.reference == idJoueur)
              .position += 1;
          copie--;
        }
        lstJoueur
            .firstWhere((element) => element.reference == idJoueur)
            .position = copie;
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
    String test = color.substring(0, 1).toUpperCase() + color.substring(1);
    switch (test) {
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
    int index = lstJoueur.indexWhere((element) => element.reference == id);
    print("index3 $index");
    for (Carte carte in lstCarte) {
      if (lstJoueur.elementAt(index).biens.contains(carte.position)) {
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
