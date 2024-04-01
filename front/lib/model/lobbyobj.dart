class LobbyObj {
  final String lobbyId;
  final String userId;
  final int nbJoueurs;
  final List<int> lstJoueurs;
  bool state;
  int tour;

  LobbyObj({
    required this.lobbyId,
    required this.userId,
    required this.nbJoueurs,
    required this.lstJoueurs,
    required this.state,
    required this.tour,
  });

  factory LobbyObj.fromJson(Map<String, dynamic> json) {
    // Convertir la liste de joueurs de type String en liste de type int
    List<int> lstJoueurs = [
      int.parse(json["j1"]),
      int.parse(json["j2"]),
      int.parse(json["j3"]),
      int.parse(json["j4"])
    ];

    return LobbyObj(
      lobbyId: json['id'].toString(),
      userId: json['user_id'].toString(),
      nbJoueurs: json['nombreDeJoueur'],
      lstJoueurs: lstJoueurs,
      state: json['state'] == 1 ? true : false,
      tour: json['tour'],
    );
  }

  Map<String, dynamic> toJson() {
    // Convertir la liste de joueurs de type int en String avec des virgules
    String lstJoueursString = lstJoueurs.join(',');

    return {
      'lobby_id': lobbyId,
      'user_id': userId,
      'nb_joueurs': nbJoueurs,
      'lst_joueurs': lstJoueursString,
      'state': state,
      'tour': tour,
    };
  }
}
