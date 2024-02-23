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
      position: json['position'],
      acheteurId: json['acheteurId'],
      maison: json['maison'],
      hotel: json['hotel'],
      image: json['image'],
      chance: json['chance'],
      communaute: json['communaute'],
      prison: json['prison'],
      goprison: json['goprison'],
      parc: json['parc'],
      prixHotel: json['prixHotel'],
      prixMaison: json['prixMaison'],
      depart: json['depart']);

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'prix': prix,
        'couleur': couleur,
        'position': position,
        'acheteurId': acheteurId,
        'maison': maison,
        'hotel': hotel,
        'image': image,
        'chance': chance,
        'communaute': communaute,
        'prison': prison,
        'goprison': goprison,
        'parc': parc,
        'depart': depart,
        'prixHotel': prixHotel,
        'prixMaison': prixMaison,
      };

  String toJsonString() => json.encode(toJson());

  factory Carte.fromJsonString(String jsonString) =>
      Carte.fromJson(json.decode(jsonString));
}
