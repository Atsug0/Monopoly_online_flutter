import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/model/carte.dart';

class InfoCard extends StatelessWidget {
  final Carte carte;
  const InfoCard({super.key, required this.carte});

  @override
  Widget build(BuildContext context) {
    int res = GameManager.cardManager.getOwner(carte);
    if (res != -999) {
      res = GameManager.cardManager.lstJoueur
              .firstWhere((element) => element.reference == carte.acheteurId)
              .id;
    }
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
                  height: 428,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Info Carte",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontFamily: 'Kabel-Bold',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              if (carte.prix != 0)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Loyer : ${carte.prix} €",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        fontFamily: 'Kabel-Bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              if (carte.prix > 0)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "prix maison : ${carte.prixMaison} €",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        fontFamily: 'Kabel-Bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              if (carte.prix > 0)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "prix hotel : ${carte.prixHotel} €",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        fontFamily: 'Kabel-Bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              if (carte.prix >= 0)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    res !=
                                            -999
                                        ? "Acquis par le joueur $res"
                                        : "Non Acquis",
                                    textScaleFactor: 1,
                                    style: const TextStyle(
                                        fontFamily: 'Kabel-Bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
