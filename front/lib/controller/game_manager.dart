import 'dart:async';
import 'dart:math';

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

    print(lobby.lstJoueurs);
  }

  static const lst_chances = [
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

  static const lst_communautes = [
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

  Future<String> getChance() async {
    final Random random = Random();
    final index = random.nextInt(lst_chances.length);
    switch (index) {
      case 0:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 39;
        break;
      case 1:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 0;
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 400;
        break;
      case 2:
        if (lstJoueur
                .firstWhere((element) => element.reference == lobby.tour)
                .position >
            24) {
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .argent += 200;
        }
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 24;
        break;
      case 3:
        if (lstJoueur
                .firstWhere((element) => element.reference == lobby.tour)
                .position >
            11) {
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .argent += 200;
        }
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 11;
        break;
      case 4:
        break;
      case 5:
        if (lstJoueur
                .firstWhere((element) => element.reference == lobby.tour)
                .position >
            15) {
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .argent += 200;
        }
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 15;
        break;
      case 6:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 100;
        break;
      case 7:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 50;
        break;
      case 8:
        break;
      case 9:
        if (lstJoueur
                    .firstWhere((element) => element.reference == lobby.tour)
                    .position -
                3 <
            0) {
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .argent += 200;
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .position = lstJoueur
                  .firstWhere((element) => element.reference == lobby.tour)
                  .position -
              3 +
              39;
        } else {
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .position -= 3;
        }

        break;
      case 10:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 10;
        break;
      case 11:
        break;
      case 12:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 15;
        break;
      case 13:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 150;
        break;
      case 14:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent -= 20;
        break;
      case 15:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 150;
        break;
    }
    if (SocketManager.socketmanager.onSocketUpdatePlateau != null) {
      SocketManager.socketmanager.onSocketUpdatePlateau!();
    }
    return lst_chances[index];
  }

  Future<String> getCommunaute() async {
    final Random random = Random();
    final index = random.nextInt(lst_communautes.length);
    lstJoueur
        .firstWhere((element) => element.reference == lobby.tour)
        .position = 0;
    lstJoueur.firstWhere((element) => element.reference == lobby.tour).argent +=
        400;
    switch (index) {
      case 0:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 0;
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 400;
        break;
      case 1:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 200;
        break;
      case 2:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 50;
        break;
      case 3:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 50;
        break;
      case 4:
        break;
      case 5:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 10;
        break;
      case 6:
        if (lstJoueur
                .firstWhere((element) => element.reference == lobby.tour)
                .position >
            1) {
          lstJoueur
              .firstWhere((element) => element.reference == lobby.tour)
              .argent += 200;
        }
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .position = 1;
        break;
      case 7:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 100;
        break;
      case 8:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 10;
        break;
      case 9:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 20;
        break;
      case 10:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 25;
        break;
      case 11:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent -= 50;
        break;
      case 12:
        break;
      case 13:
        break;
      case 14:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 10;
        break;
      case 15:
        lstJoueur
            .firstWhere((element) => element.reference == lobby.tour)
            .argent += 100;
        break;
    }
    return lst_communautes[index];
  }

  bool achetable(int id) {
    int index = lstJoueur.indexWhere((element) => element.reference == id);
    Joueur j = lstJoueur.elementAt(index);
    Carte c = lstCarte.firstWhere((element) => element.position == j.position);
    if (j.argent > c.prix) {
      return true;
    }
    return false;
  }

  int getIdTurn() {
    return lobby.tour;
  }

  Future<void> endTurn() async {
    bool test = true;
    for (Carte c in lstCarte) {
      await JsManager.jsmanager.updatecartes(c);
    }
    for (Joueur j in lstJoueur) {
      await JsManager.jsmanager.updatejoueur(j);
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
    await JsManager.jsmanager
        .updategame(int.parse(lobby.lobbyId), lobby.state, lobby.tour);
    SocketManager.socketmanager
        .updateData(SocketManager.socketmanager.idgame ?? "");
    if (SocketManager.socketmanager.onSocketUpdatePlateau != null) {
      SocketManager.socketmanager.onSocketUpdatePlateau!();
    }
    Timer(Duration(seconds: 2), () {
      if (lobby.tour < 0) {
        iatour();
      }
    });
  }

  void iatour() async {
    Random random = Random();
    int dep = random.nextInt(6) + random.nextInt(6) + 2;
    int index =
        lstJoueur.indexWhere((element) => element.reference == lobby.tour);
    Joueur j = lstJoueur.elementAt(index);
    Carte c = lstCarte.firstWhere((element) => element.position == j.position);
    deplacement(lobby.tour, dep);
    j = lstJoueur.elementAt(index);
    c = lstCarte.firstWhere((element) => element.position == j.position);
    int ac = action(lobby.tour);
    if (ac == 6) {
      if (achetable(lobby.tour)) {
        achat(lobby.tour, c.position, c.prix);
        j = lstJoueur.elementAt(index);
        await endTurn();
        return;
      }
    }
    j = lstJoueur.elementAt(index);
    await endTurn();
    return;
  }

  void transaction(int id1, int id2, int prix) {
    lstJoueur.firstWhere((element) => element.reference == id1).argent -= prix;
    lstJoueur.firstWhere((element) => element.reference == id2).argent += prix;
    if (SocketManager.socketmanager.onSocketUpdatePlateau != null) {
      SocketManager.socketmanager.onSocketUpdatePlateau!();
    }
  }

  void prelevement(int id1, int prix) {
    int index = lstJoueur.indexWhere((element) => element.reference == id1);
    lstJoueur.elementAt(index).argent += prix;
    lstCarte.firstWhere((element) => element.parc >= 1).parc += (-prix);
  }

  void wincagnotte(int id1) {
    int index = lstJoueur.indexWhere((element) => element.reference == id1);
    lstJoueur.elementAt(index).argent +=
        lstCarte.firstWhere((element) => element.parc >= 1).parc;
    lstCarte.firstWhere((element) => element.parc >= 1).parc = 1;
  }

  void achat(int idJoueur, int idCard, int prix) {
    int index =
        lstJoueur.indexWhere((element) => element.reference == idJoueur);
    lstJoueur.elementAt(index).argent -= prix;
    lstJoueur.elementAt(index).biens.add(idCard);
    lstCarte.firstWhere((element) => element.position == idCard).acheteurId =
        idJoueur;
    if (SocketManager.socketmanager.onSocketUpdatePlateau != null) {
      SocketManager.socketmanager.onSocketUpdatePlateau!();
    }
  }

  void deplacement(int idJoueur, int nbr) {
    int index =
        lstJoueur.indexWhere((element) => element.reference == idJoueur);
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
        lstJoueur
            .firstWhere((element) => element.reference == idJoueur)
            .argent += 200;
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
    if (SocketManager.socketmanager.onSocketUpdatePlateau != null) {
      SocketManager.socketmanager.onSocketUpdatePlateau!();
    }
  }

  int action(int id) {
    Joueur j = lstJoueur.firstWhere((element) => element.reference == id);
    Carte c = lstCarte.firstWhere((element) => element.position == j.position);
    int j2 = getOwner(c);

    if (j2 != -999 && c.prix > 0) {
      transaction(j.reference, j2, c.prix);
      return (0);
    } else {
      if (c.prix < 0) {
        prelevement(j.reference, c.prix);
        return (7);
      }
      if (c.chance) {
        return (1);
      }
      if (c.communaute) {
        return (2);
      }
      if (c.goprison) {
        int index =
            lstJoueur.indexWhere((element) => element.reference == j.reference);
        lstJoueur.elementAt(index).position = 10;
        return (3);
      }
      if (c.prison) {
        return (4);
      }
      if (c.position == 20) {
        wincagnotte(j.reference);
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
      if (c.parc >= 1) {
        return c.parc;
      }
    }
    return 0;
  }

  int getOwner(Carte carte) {
    for (Joueur j in lstJoueur) {
      if (carte.acheteurId == j.reference) {
        return j.reference;
      }
    }
    return -999;
  }

  List<String> getListAddr(int id) {
    List<String> res = [];
    int index = lstJoueur.indexWhere((element) => element.reference == id);
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
