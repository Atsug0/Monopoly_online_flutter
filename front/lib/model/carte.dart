import 'dart:convert';

class Carte {
  String nom;
  int prix;
  String couleur;
  int position;
  int acheteurId;
  int maison;
  int hotel;
  int prixMaison;
  int prixHotel;
  String image;
  bool chance;
  bool communaute;
  bool prison;
  bool goprison;
  bool depart;
  int parc;

  Carte({
    required this.nom,
    required this.prix,
    required this.couleur,
    required this.position,
    required this.acheteurId,
    required this.maison,
    required this.hotel,
    required this.image,
    required this.chance,
    required this.communaute,
    required this.prixHotel,
    required this.prixMaison,
    required this.prison,
    required this.goprison,
    required this.depart,
    required this.parc,
  });

  factory Carte.fromJson(Map<String, dynamic> json) => Carte(
        nom: json['nom'],
        prix: json['prix'],
        couleur: json['couleur'],
        acheteurId: json['acheteur_id'],
        maison: json['maison'],
        hotel: json['hotel'],
        image: json['image'],
        chance: json['chance'] == 0 ? false : true,
        communaute: json['communaute'] == 0 ? false : true,
        prison: json['prison'] == 0 ? false : true,
        depart: json['depart'] == 0 ? false : true,
        parc: json['parc'],
        goprison: json['goprison'] == 0 ? false : true,
        prixHotel: json['prix_hotel'],
        prixMaison: json['prix_maison'],
        position: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': position,
        'nom': nom,
        'prix': prix,
        'couleur': couleur,
        'acheteur_id': acheteurId,
        'maison': maison,
        'hotel': hotel,
        'image': image,
        'chance': chance ? 1 : 0,
        'communaute': communaute ? 1 : 0,
        'prison': prison ? 1 : 0,
        'depart': depart ? 1 : 0,
        'parc': parc,
        'goprison': goprison ? 1 : 0,
        'prix_hotel': prixHotel,
        'prix_maison': prixMaison,
      };

  String toJsonString() => json.encode(toJson());

  factory Carte.fromJsonString(String jsonString) =>
      Carte.fromJson(json.decode(jsonString));

  static List<Carte> parseCartes(String jsonStr) {
    final parsed = json.decode(jsonStr).cast<Map<String, dynamic>>();
    return parsed.map<Carte>((json) => Carte.fromJson(json)).toList();
  }
}
