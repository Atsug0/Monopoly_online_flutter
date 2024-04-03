import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';
import 'package:monopoly/model/lobbyobj.dart';

void main() {
  group('GameManager', () {
    GameManager gameManager = GameManager();
    List<Joueur> players = [
      Joueur(
          reference: 1,
          couleur: "Red",
          biens: [1, 3],
          argent: 1500,
          prison: false,
          position: 4,
          id: 0,
          cartes: [1, 2]),
      Joueur(
          reference: 2,
          couleur: "Blue",
          biens: [5, 8],
          argent: 1500,
          prison: false,
          position: 36,
          id: 1,
          cartes: [5]),
    ];
    List<Carte> cards = [
      Carte(
          position: 1,
          nom: 'test1',
          prix: 500,
          acheteurId: 1,
          couleur: 'Red',
          maison: 15,
          hotel: 15,
          image: '',
          chance: false,
          communaute: false,
          prixHotel: 10,
          prixMaison: 10,
          prison: false,
          goprison: false,
          depart: false,
          parc: 0),
      Carte(
          position: 2,
          nom: 'test2',
          prix: 500,
          acheteurId: 1,
          couleur: 'SaddleBrown',
          maison: 15,
          hotel: 15,
          image: '',
          chance: false,
          communaute: false,
          prixHotel: 10,
          prixMaison: 10,
          prison: false,
          goprison: false,
          depart: false,
          parc: 0),
      Carte(
          position: 3,
          nom: 'test3',
          prix: 500,
          acheteurId: 1,
          couleur: 'DarkOrchid',
          maison: 15,
          hotel: 15,
          image: '',
          chance: false,
          communaute: false,
          prixHotel: 10,
          prixMaison: 10,
          prison: false,
          goprison: false,
          depart: false,
          parc: 0),
      Carte(
          position: 4,
          nom: 'test4',
          prix: 500,
          acheteurId: 1,
          couleur: 'Green',
          maison: 15,
          hotel: 15,
          image: '',
          chance: false,
          communaute: false,
          prixHotel: 10,
          prixMaison: 10,
          prison: false,
          goprison: false,
          depart: false,
          parc: 10),
    ];
    gameManager.lstJoueur = players;
    gameManager.lstCarte = cards;
    test('Test getColor', () {
      expect(gameManager.getColor("SaddleBrown"), const Color(0xFF8b4513));
      expect(gameManager.getColor("DarkOrchid"), const Color(0xFF9932CC));
      expect(gameManager.getColor("Red"), equals(Colors.red));
    });

    test('Test getCardColor', () {
      expect(gameManager.getCardColor(gameManager.lstCarte.first),
          equals(Color(0x66f44336)));
    });

    test('Test achetable', () {
      expect(gameManager.achetable(1), equals(true));
    });

    test('Test transaction', () {
      gameManager.transaction(1, 2, 100);
      expect(gameManager.lstJoueur.first.argent, 1400);
      expect(gameManager.lstJoueur[1].argent, 1600);
    });

    test('Test prelevement', () {
      gameManager.prelevement(1, -200);
      expect(gameManager.lstJoueur.first.argent, 1200);
    });

    test('Test wincagnotte', () {
      // Ajoutez vos cas de test pour la méthode wincagnotte
      gameManager.wincagnotte(1);
      expect(gameManager.lstJoueur.first.argent, 1410);
    });

    test('Test achat', () {
      // Ajoutez vos cas de test pour la méthode achat
      gameManager.achat(1, 1, 10);
      expect(gameManager.lstJoueur.first.argent, 1400);
      expect(gameManager.lstJoueur.first.biens.contains(1), true);
      expect(gameManager.lstCarte.first.acheteurId, 1);
    });

    test('Test deplacement', () {
      // Ajoutez vos cas de test pour la méthode deplacement
      gameManager.deplacement(1, 8);
      expect(gameManager.lstJoueur.first.position, 12);
    });

    test('Test getCagnote', () {
      expect(gameManager.getCagnote(), 1);
    });

    test('Test getOwner', () {
      expect(gameManager.getOwner(gameManager.lstCarte.first), 1);
    });

    test('Test getListAddr', () {
      expect(gameManager.getListAddr(1), ['test1', 'test3']);
    });

    test('Test isSpecial', () {
      expect(gameManager.isSpecial(gameManager.lstCarte.first), false);
    });
  });
}
