import 'dart:convert';

import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/navigator_key.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static SocketManager socketmanager = SocketManager();
  late io.Socket socket;
  String? idgame = null;
  List<int> players = [];
  void Function()? onSocketUpdateLobby;
  void Function()? onSocketUpdatePlateau;

  // Méthode pour appeler la fonction de callback
  void notifySocketUpdateLobby() {
    onSocketUpdateLobby?.call();
  }

  // Méthode pour appeler la fonction de callback
  void notifySocketUpdatePlateau() {
    onSocketUpdatePlateau?.call();
  }

  void init() {
    socket = io.io('http://localhost:8008', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('playersList', (data) {
      fetchdata(data);
    });

    socket.on('gameStarted', (_) {
      print('Game started');
      navigatorKey.currentState?.pushNamed("plateau");
    });

    socket.on('dataUpdate', (_) async {
      print("data update");
      await JsManager.jsmanager.getjoueurs();
      await JsManager.jsmanager.getcartes();
      await JsManager.jsmanager.getgame(int.parse(GameManager.cardManager.lobby.lobbyId));
      notifySocketUpdatePlateau();
    });

    socket.on('gameEnded', (_) {
      print('Game ended');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    });

    socket.on('gamestate', (data) async {
      print("data : $data");
      await JsManager.jsmanager.getgame(data);
    });

    socket.on('errorRoom', (err) {
      print("erreur : $err");
    });
  }

  void createGame() {
    int id = int.parse(JsManager.jsmanager.prefs.getString('id') ?? "-1");
    print("id = $id");

    if (id == -1) {
      return;
    }
    socket.emit('createGame', {id});
  }

  void joinGame(String room) {
    int id = int.parse(JsManager.jsmanager.prefs.getString('id') ?? "-1");
    print("id = $id");

    if (id == -1) {
      return;
    }
    socket.emit('joinGame', {room, id});
  }

  void startGame(String room, int id) {
    socket.emit('startGame', {room, id});
  }

  void addBot(String room, int id) {
    socket.emit('addBot', {room, id});
  }

  void deleteBot(String room, int id) {
    socket.emit('deleteBot', {room, id});
  }

  void updateData(String room) {
    socket.emit('updateData', {room});
  }

  void endGame(String room) {
    socket.emit('endGame', {room});
  }

  void fetchdata(dynamic json) {
    // Récupérer le gameId d'une entrée dans la liste
    idgame = json[0]['gameId'];
    print(json);
    print('Game ID: $idgame');
    // Stocker tous les playerId dans une liste d'entiers
    players = [];
    for (var playerData in json) {
      int playerId = playerData['playerId'];
      players.add(playerId);
    }
    notifySocketUpdateLobby();
  }
}

    
    
    // Fin de partie
    //endGame
    
    //disconnect