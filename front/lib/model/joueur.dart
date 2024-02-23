import 'dart:convert';

class Joueur {
  int id;
  String? reference;
  int argent;
  String couleur;
  List<int> biens;
  List<int> cartes;
  bool prison;
  int position;

  Joueur({
    required this.id,
    required this.argent,
    required this.reference,
    required this.couleur,
    required this.biens,
    required this.cartes,
    required this.prison,
    required this.position,
  });

  factory Joueur.fromJson(Map<String, dynamic> json) => Joueur(
        id: json['id'],
        reference: json['reference'],
        argent: json['argent'],
        couleur: json['couleur'],
        biens: List<int>.from(json['biens']),
        cartes: List<int>.from(json['cartes']),
        prison: json['prison'],
        position: json['position'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reference': reference,
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
