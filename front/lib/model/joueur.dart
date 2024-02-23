import 'dart:convert';

class Joueur {
  int id;
  int argent;
  String couleur;
  List<int> biens;
  List<int> cartes;
  bool prison;
  int position;

  Joueur({
    required this.id,
    required this.argent,
    required this.couleur,
    required this.biens,
    required this.cartes,
    required this.prison,
    required this.position,
  });

  factory Joueur.fromJson(Map<String, dynamic> json) => Joueur(
        id: json['id'],
        argent: json['argent'],
        couleur: json['couleur'],
        biens: List<int>.from(json['biens']),
        cartes: List<int>.from(json['cartes']),
        prison: json['prison'],
        position: json['position'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'argent': argent,
        'biens': biens,
        'cartes': cartes,
        'prison': prison,
        'position': position,
        'couleur': couleur
      };

  String toJsonString() => json.encode(toJson());

  factory Joueur.fromJsonString(String jsonString) =>
      Joueur.fromJson(json.decode(jsonString));
}
