import 'dart:convert';

import 'package:http/http.dart' as http;

class JsManager {
  static JsManager jsmanager = JsManager();

  // Fonction pour envoyer la requête POST
  Future<void> createUser(
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
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
    }
  }

  // Fonction pour envoyer la requête POST
  Future<void> authenticateUser(String input, String password) async {
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
      } else {
        print(
            'Échec de la requête avec le code de statut: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
    }
  }
}
