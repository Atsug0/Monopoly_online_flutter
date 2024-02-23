import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';

class PopUpAchat extends StatelessWidget {
  final int id;
  const PopUpAchat({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Joueur j = GameManager.cardManager.lstJoueur.elementAt(id);
    Carte c = GameManager.cardManager.lstCarte
        .firstWhere((element) => element.position == j.position);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 528,
                  width: 298,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2851).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 30, bottom: 28),
                        child: Container(
                          height: 312,
                          width: 238,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2851),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "Tu as assez d'argent pour acheter ${c.nom}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'Kabel-Bold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            height: 44,
                            width: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E2851),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "Ok",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontFamily: 'Kabel-Bold',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            height: 44,
                            width: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E2851),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "Non merci",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontFamily: 'Kabel-Bold',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
