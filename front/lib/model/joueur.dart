import 'dart:convert';

class Joueur {
  int id;
  int reference;
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

  static List<int> stringToIntList(String input) {
    if (input.isEmpty) {
      return [];
    }
    List<String> parts = input.split(',');
    parts.removeWhere((element) => element.isEmpty);
    List<int> result = parts.map((e) => int.tryParse(e) ?? 0).toList();

    return result;
  }

  factory Joueur.fromJson(Map<String, dynamic> json) => Joueur(
        id: json['id'],
        reference: json['user_id'],
        argent: json['argent'],
        couleur: json['couleur'],
        biens: stringToIntList(json['biens'] as String),
        cartes: stringToIntList(json['cartes'] as String),
        prison: json['prison'] == 0 ? false : true,
        position: json['position'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': reference,
        'argent': argent,
        'couleur': couleur,
        'biens': biens.isNotEmpty ? biens.join(',') : "",
        'cartes': cartes.isNotEmpty ? cartes.join(',') : "",
        'prison': prison ? 1 : 0,
        'position': position,
      };

  String toJsonString() => json.encode(toJson());

  factory Joueur.fromJsonString(String jsonString) =>
      Joueur.fromJson(json.decode(jsonString));

  static List<Joueur> parseJoueurs(String jsonStr) {
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    return parsed.map<Joueur>((json) => Joueur.fromJson(json)).toList();
  }
}
