import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:monopoly/model/carte.dart';
import 'package:monopoly/model/joueur.dart';

class JsManager {
  static JsManager jsmanager = JsManager();
  bool isConnected = false;

  // Fonction pour envoyer la requête POST
  Future<bool> createUser(
      String username, String email, String password) async {
    Map<String, String> requestBody = {
      'username': username,
      'email': email,
      'password': password,
    };

    // Faire la requête POST
    try {
      final response = await http.post(
          Uri.http('localhost:8000', '/api/registeruser'),
          body: json.encode(requestBody),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return true;
    }
  }

  // Fonction pour envoyer la requête POST
  Future<bool> authenticateUser(String input, String password) async {
    Map<String, String> requestBody = {
      'input': input,
      'password': password,
    };

    // Faire la requête POST
    try {
      final response = await http.post(
          Uri.parse('http://localhost:8000/api/authenticateuser'),
          body: json.encode(requestBody),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        isConnected = true;
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> getjoueurwithid(int id) async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8000/api/getjoueurwithid?id=$id'),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> updatejoueur(Joueur j) async {
    String lstbien = "";
    for (int i in j.biens) {
      lstbien = "$lstbien$i,";
    }
    String lstcartes = "";
    for (int i in j.cartes) {
      lstcartes = "$lstcartes$i,";
    }
    Map<String, dynamic> requestBody = {
      'user_id': j.id,
      'argent': j.argent,
      'couleur': j.couleur,
      'lst_biens': lstbien,
      'lst_cartes': lstcartes,
      'prison': j.prison,
      'position': j.position
    };

    // Faire la requête POST
    try {
      final response = await http.put(
          Uri.parse('http://localhost:8000/api/updatejoueur'),
          body: json.encode(requestBody),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> getgame(int id) async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8000/api/getgame?id=$id'), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> updategame(int lobbyid, bool state, int tour) async {
    Map<String, dynamic> requestBody = {
      'lobby_id': lobbyid,
      'state': state,
      'tour': tour
    };

    // Faire la requête POST
    try {
      final response = await http.put(
          Uri.parse('http://localhost:8000/api/updategame'),
          body: json.encode(requestBody),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> getinfosuserwithid(int id) async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost:8000/api/getinfosuserwithid?id=$id'),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> createGame(
      int lobbyid, int userid, int nbjoueurs, List<int> lstJoueurs) async {
    String lstj = "";
    for (int i in lstJoueurs) {
      lstj = "$lstj$i,";
    }
    Map<String, dynamic> requestBody = {
      'lobby_id': lobbyid,
      'user_id': userid,
      'nb_joueurs': nbjoueurs,
      'lst_joueurs': lstJoueurs,
      'state': true,
      'tour': userid
    };

    // Faire la requête POST
    try {
      final response = await http.post(
          Uri.parse('http://localhost:8000/api/creategame'),
          body: json.encode(requestBody),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> updatecartes(Carte carte) async {
    Map<String, dynamic> requestBody = {
      'carte_id': carte.position,
      'acheteur_id': carte.acheteurId,
      'maison': carte.maison,
      'hotel': carte.hotel,
      'parc': carte.parc
    };

    // Faire la requête POST
    try {
      final response = await http.put(
          Uri.parse('http://localhost:8000/api/updatecartes'),
          body: json.encode(requestBody),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> getcartes() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8000/api/getcartes'), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }

  Future<bool> getjoueurs() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:8000/api/getjoueur'), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        print('Réponse du serveur: ${response.body}');
        return true;
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      return false;
    }
  }
}
