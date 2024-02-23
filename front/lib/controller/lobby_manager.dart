class LobbyManager {
  static LobbyManager lobbyManager = LobbyManager();
  bool create = false;
  bool join = false;
  int? idLobby;
  late int idPlayer;

  void createLobby() {}
  void joinLobby() {}
  void getIdPlayers() {
    idPlayer = 0;
  }
}
