import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/navigator_key.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  late int _nbrConnection;
  late int _nbrBot;

  @override
  void initState() {
    _nbrConnection = 1;
    _nbrBot = 0;
    super.initState();
  }

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
                      //envoyer la demande de fin de lobby
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
            Spacer(),
            AutoSizeText(
              "Il y a $_nbrConnection Joueur(s)",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Kabel-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
              maxLines: 2,
            ),
            AutoSizeText(
              "Le code de la salle est ....",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Kabel-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  //gérer les bots
                  if (_nbrConnection < 4) {
                    setState(() {
                      _nbrConnection += 1;
                      _nbrBot += 1;
                    });
                  }
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
                      "Ajouter un Bot",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (_nbrConnection >= 2 && _nbrBot > 0) {
                    //gérer les bots
                    setState(() {
                      _nbrConnection -= 1;
                      _nbrBot -= 1;
                    });
                  }
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
                      "Supprimer un Bot",
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
            _nbrConnection == 4 ?
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () async {
                    //await JsManager.jsmanager.createGame(0, 0, 4, [0,1,2,3]);
                    navigatorKey.currentState?.pushNamed("plateau");
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
                        "Lancer la partie",
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
              ) : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    height: 54,
                    width: 200,),
              ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
