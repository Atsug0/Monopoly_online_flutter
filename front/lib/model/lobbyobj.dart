class LobbyObj {
  final String lobbyId;
  final String userId;
  final int nbJoueurs;
  final List<int> lstJoueurs;
  final bool state;
  final int tour;

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
    List<int> lstJoueurs = json['lst_joueurs'].split(',').map(int.parse).toList();

    return LobbyObj(
      lobbyId: json['lobby_id'],
      userId: json['user_id'],
      nbJoueurs: json['nb_joueurs'],
      lstJoueurs: lstJoueurs,
      state: json['state'],
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
