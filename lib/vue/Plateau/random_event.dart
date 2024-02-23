import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/model/carte.dart';

class RandomEvent extends StatelessWidget {
  final String phrase;
  const RandomEvent({super.key, required this.phrase});

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
                  height: 398,
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
                          height: 282,
                          width: 238,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2851),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                phrase,
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontFamily: 'Kabel-Bold',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
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
