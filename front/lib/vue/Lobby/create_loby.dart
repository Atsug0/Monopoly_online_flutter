import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/socket.controller.dart';
import 'package:monopoly/controller/navigator_key.dart';

class Lobby extends StatefulWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  int _nbrConnection = 1;
  int _nbrBot = 0;

  @override
  void initState() {
    super.initState();
    SocketManager.socketmanager.onSocketUpdateLobby = _onSocketUpdate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSocketUpdate() {
    setState(() {
      _nbrConnection = SocketManager.socketmanager.players.length + _nbrBot;
    }); // Mettre à jour l'état de la page lorsque les données du socket changent
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
                      // Envoyer la demande de fin de lobby
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
              "Il y a ${SocketManager.socketmanager.players.length} Joueur(s)",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Kabel-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
              maxLines: 2,
            ),
            AutoSizeText(
              "Le code de la salle est ${SocketManager.socketmanager.idgame ?? '...'}",
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
                  // Gérer les bots
                  if (SocketManager.socketmanager.players.length < 4) {
                    setState(() {
                      _nbrBot -= 1;
                      SocketManager.socketmanager.addBot(
                          SocketManager.socketmanager.idgame ?? "", _nbrBot);
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
                  if (_nbrBot < 0) {
                    // Gérer les bots
                    setState(() {
                      SocketManager.socketmanager.deleteBot(
                          SocketManager.socketmanager.idgame ?? "", _nbrBot);
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
            SocketManager.socketmanager.players.length == 4
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () async {
                        //await JsManager.jsmanager.createGame(0, 0, 4, [0,1,2,3]);
                        if (SocketManager.socketmanager.players.isNotEmpty) {
                          int id = int.parse(
                              JsManager.jsmanager.prefs.getString('id') ??
                                  "-1");
                          if (id != -1 &&
                              id == SocketManager.socketmanager.players.first) {
                            navigatorKey.currentState?.pushNamed("plateau");
                            int sum = 0;
                            String idgame =
                                SocketManager.socketmanager.idgame ?? "";
                            for (int i = 0; i < idgame.length; i++) {
                              sum += idgame.codeUnitAt(i);
                            }
                            await JsManager.jsmanager.createGame(
                                sum,
                                SocketManager.socketmanager.players.first,
                                SocketManager.socketmanager.players.length,
                                SocketManager.socketmanager.players);
                            SocketManager.socketmanager.startGame(idgame, sum);
                          }
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
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 54,
                      width: 200,
                    ),
                  ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
