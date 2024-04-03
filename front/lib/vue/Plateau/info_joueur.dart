import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/game_manager.dart';

class InfoJoueur extends StatelessWidget {
  final int id;
  const InfoJoueur({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
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
                          width: 238,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2851),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "Liste des cartes acquise par le joueur",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontFamily: 'Kabel-Bold',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                for (int i = 0;
                                    i <
                                        GameManager.cardManager
                                            .getListAddr(id)
                                            .length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                     GameManager.cardManager
                                            .getListAddr(id)
                                            [i],
                                      textScaleFactor: 1,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontFamily: 'Kabel-Bold',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            ),
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
