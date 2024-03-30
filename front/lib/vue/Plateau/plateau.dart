import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/controller/lobby_manager.dart';
import 'package:monopoly/controller/socket.controller.dart';
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';
import 'package:monopoly/vue/Plateau/info_card.dart';
import 'package:monopoly/vue/Plateau/info_joueur.dart';
import 'package:monopoly/vue/Plateau/popup_achat.dart';
import 'package:monopoly/vue/Plateau/random_event.dart';

class MonopolyBoard extends StatefulWidget {
  const MonopolyBoard({super.key});

  @override
  State<MonopolyBoard> createState() => _MonopolyBoardState();
}

class _MonopolyBoardState extends State<MonopolyBoard> {
  late int leftid;
  late int rightid;
  late int topid;
  late int bottomid;
  late bool de;
  @override
  void initState() {
    SocketManager.socketmanager.onSocketUpdatePlateau = _onSocketUpdate;
    List<int> lid = [0, 1, 2, 3];
    de = false;
    LobbyManager.lobbyManager.getIdPlayers();
    bottomid = LobbyManager.lobbyManager.idPlayer;
    lid.removeWhere((element) => element == bottomid);
    leftid = lid.removeAt(0);
    rightid = lid.removeAt(0);
    topid = lid.removeAt(0);
    super.initState();
  }

  void _onSocketUpdate() {
    print("update");
    setState(
        () {}); // Mettre à jour l'état de la page lorsque les données du socket changent
  }

  //si c'est ton tour
  // lancez les dés
  // faire le déplacement
  // si case libre pop up achat
  // si case déjà acheté pop up paiement
  // sinon pop up carte chance ou caisse de comunauté avec l action
  // quand cela est fait
  // voit si peu acheté maison ou hotel, un bouton apparait sinon il peut cliquer direct sur les cases.
  // un bouton fin de tour apparait aussi

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.96,
            width: MediaQuery.sizeOf(context).width * 0.825,
            color: const Color(0xFFBFDBAE), // Background color of the board
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 10)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 11)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 12)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 13)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 14)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 15)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 16)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 17)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 18)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 19)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 20)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 9)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 21)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 2,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 8)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 22)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 3,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 7)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 23)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 4,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 6)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 24)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 5,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 5)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 25)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 6,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 4)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 26)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 7,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 3)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 27)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 8,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 2)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 28)
                        .first),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 9,
                left: 0,
                right: 1,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 1)
                        .first),
                    const Spacer(),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 29)
                        .first),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 0)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 39)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 38)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 37)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 36)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 35)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 34)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 33)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 32)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 31)
                        .first),
                    buildProperty(GameManager.cardManager.lstCarte
                        .where((element) => element.position == 30)
                        .first),
                  ],
                ),
              ),
              Positioned(
                  bottom: MediaQuery.sizeOf(context).height * 0.96 / 11 * 1.5,
                  left: 0,
                  right: 0,
                  child: getPlayerCard(bottomid)),
              Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 1.5,
                  left: 0,
                  right: 0,
                  child: getPlayerCard(topid)),
              Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 5,
                  left: MediaQuery.sizeOf(context).width * 0.95 / 11,
                  child: getPlayerCard(leftid)),
              Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 5,
                  right: MediaQuery.sizeOf(context).width * 0.95 / 11,
                  child: getPlayerCard(rightid)),
              Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 5,
                  right: 0,
                  left: 0,
                  child: getParcPrice()),
              if (de == false &&
                  GameManager.cardManager.getIdTurn() == bottomid)
                Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.96 / 11 * 6.5,
                    right: MediaQuery.sizeOf(context).width * 0.825 / 11 * 4.5,
                    left: MediaQuery.sizeOf(context).width * 0.825 / 11 * 4.5,
                    child: GestureDetector(
                      onTap: () {
                        //lance le dé
                        Random random = Random();
                        int deplacement =
                            random.nextInt(6) + random.nextInt(6) + 2;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RandomEvent(
                                  phrase: "Tu as fais $deplacement");
                            }).then((value) {
                          setState(() {
                            GameManager.cardManager
                                .deplacement(bottomid, deplacement);
                            int res = GameManager.cardManager.action(bottomid);
                            doAction(res);
                          });
                        });
                        //affiche la popup du résultat
                        //puis quand ok fais le déplacement
                        //fais les actions à la fin du déplacement
                      },
                      child: Container(
                        height: 54,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF1E2851),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: const Center(
                          child: AutoSizeText(
                            "Lance le dé",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Kabel-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    )),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildProperty(Carte carte) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.96 / 11,
      width: MediaQuery.sizeOf(context).width * 0.825 / 11,
      decoration: BoxDecoration(
        color: GameManager.cardManager.getCardColor(carte),
        border: Border.all(
          color: carte.nom.isEmpty ? Colors.white : Colors.black,
          width: 1,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return InfoCard(
                            carte: carte,
                          );
                        },
                      ).then((value) {});
                    },
                    child: AutoSizeText(
                      carte.nom,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: 'Kabel-Bold',
                        fontWeight: FontWeight.w500,
                        fontSize: 6.0,
                        color: GameManager.cardManager.getColor(carte.couleur),
                      ),
                    ),
                  ),
                ),
              ),
              if (!GameManager.cardManager.isSpecial(carte))
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AutoSizeText(
                      "${carte.prix} \€",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Kabel-Bold',
                        fontWeight: FontWeight.w500,
                        fontSize: 8.0,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
            ],
          ),
          Positioned(bottom: 2, child: getPlayersOnCard(carte)),
        ],
      ),
    );
  }

  Widget getPlayersOnCard(Carte carte) {
    List<Widget> players = [];
    for (Joueur j in GameManager.cardManager.lstJoueur) {
      if (j.position == carte.position) {
        players.add(Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: GameManager.cardManager.getColor(j.couleur),
            ),
          ),
        ));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: players,
    );
  }

  Widget getPlayerCard(int id) {
    Joueur j = GameManager.cardManager.lstJoueur.elementAt(id);
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          AutoSizeText(
            "Joueur ${j.id + 1}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Kabel-Bold',
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: GameManager.cardManager.getColor(j.couleur)),
            maxLines: 2,
          ),
          AutoSizeText(
            "${j.argent} €",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'Kabel-Bold',
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.black),
            maxLines: 2,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return InfoJoueur(
                        id: id,
                      );
                    }).then((value) {});
              },
              icon: const Icon(
                Icons.info_outline,
                color: Colors.black,
                size: 25,
              ))
        ],
      ),
    );
  }

  Widget getParcPrice() {
    return Material(
      color: Colors.transparent,
      child: Text(
        "La Cagnote contient\n${GameManager.cardManager.getCagnote()} €",
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Kabel-Bold',
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
            color: Colors.black),
      ),
    );
  }

  void doAction(int action) {
    switch (action) {
      case 1:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RandomEvent(phrase: GameManager.cardManager.getChance());
            }).then((value) {});
        break;
      case 2:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RandomEvent(
                  phrase: GameManager.cardManager.getCommunaute());
            }).then((value) {});
        break;
      case 3:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const RandomEvent(
                phrase: "Tu vas directement en prison",
              );
            }).then((value) {
          GameManager.cardManager.endTurn();
        });
        break;
      case 4:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const RandomEvent(
                phrase:
                    "Petite visite en prison mais t'inquiete tu n'y reste pas",
              );
            }).then((value) {});
        break;
      case 5:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const RandomEvent(
                phrase: "Bravo tu as gagné le pactole",
              );
            }).then((value) {});
        break;
      default:
        if (GameManager.cardManager.achetable(bottomid)) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return PopUpAchat(
                  id: bottomid,
                );
              }).then((value) {
            if (value != null) {
              if (value) {
                setState(() {
                  Joueur j =
                      GameManager.cardManager.lstJoueur.elementAt(bottomid);
                  Carte c = GameManager.cardManager.lstCarte
                      .firstWhere((element) => element.position == j.position);
                  GameManager.cardManager.achat(bottomid, c.position, c.prix);
                });
              }
            }
          });
        }
    }
  }
}
