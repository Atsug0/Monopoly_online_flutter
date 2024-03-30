import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/navigator_key.dart';
import 'package:monopoly/controller/socket.controller.dart';

class ConnectToLobby extends StatefulWidget {
  const ConnectToLobby({super.key});

  @override
  State<ConnectToLobby> createState() => _ConnectToLobbyState();
}

class _ConnectToLobbyState extends State<ConnectToLobby> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1E2851),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const AutoSizeText(
              "Entre le code pour te connecter à la salle",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Kabel-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 54,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF1E2851),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController,

                        decoration: const InputDecoration(
                          hintText: 'Entrez votre code',
                          hintStyle: TextStyle(
                            fontFamily: 'Kabel-Bold',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          counterText:
                              '', // Pour masquer le compteur de caractères
                          counterStyle: TextStyle(
                              fontSize:
                                  0), // Pour réduire l'espace occupé par le compteur
                          // Limiter la longueur maximale à 6 caractères
                          counter: Offstage(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Kabel-Bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        // Optionnel : pour empêcher le clavier d'afficher le bouton "Done" lorsque le texte est entré
                        textInputAction: TextInputAction.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  //faire l essai de connection
                  SocketManager.socketmanager
                      .joinGame(_textEditingController.text);
                  Timer(Duration(seconds: 2), () {
                    // Vérifier si x est différent de 3
                    if (SocketManager.socketmanager.idgame != null) {
                      navigatorKey.currentState!.pushNamed("lobby");
                    }
                  });
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
                      "Rejoindre",
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
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
