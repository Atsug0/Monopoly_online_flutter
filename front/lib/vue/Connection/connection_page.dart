import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/navigator_key.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  bool _isObscured = true;

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur de connexion'),
          content: Text('Une erreur s\'est produite lors de la connexion.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1E2851),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const AutoSizeText(
              "Connecte toi à ton compte",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Kabel-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 54,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF1E2851),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController2,
                        onChanged: (String val) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Entrez votre email ou votre identifiant',
                          hintStyle: TextStyle(
                            fontFamily: 'Kabel-Bold',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          counterText: '',
                          counterStyle: TextStyle(fontSize: 0),
                          counter: Offstage(),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Kabel-Bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        textInputAction: TextInputAction.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 54,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF1E2851),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController3,
                        onChanged: (String val) {
                          setState(() {});
                        },
                        obscureText:
                            _isObscured, // Utiliser la variable pour déterminer si le texte doit être obscurci
                        decoration: InputDecoration(
                          hintText: 'Entrez votre mot de passe',
                          hintStyle: const TextStyle(
                            fontFamily: 'Kabel-Bold',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          counterText:
                              '', // Pour masquer le compteur de caractères
                          counterStyle: const TextStyle(
                            fontSize: 0,
                          ), // Pour réduire l'espace occupé par le compteur
                          counter: const Offstage(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscured =
                                    !_isObscured; // Inverser l'état de l'obfuscation du texte
                              });
                            },
                          ), // Ajouter un bouton pour masquer ou révéler le mot de passe
                        ),
                        style: const TextStyle(
                          fontFamily: 'Kabel-Bold',
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        // Optionnel : pour empêcher le clavier d'afficher le bouton "Done" lorsque le texte est entré
                        textInputAction: TextInputAction.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_textEditingController2.text.isNotEmpty &&
                _textEditingController3.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () async {
                    //faire l essai de connection
                    bool res = await JsManager.jsmanager.authenticateUser(
                        _textEditingController2.text,
                        _textEditingController3.text);
                    if (res) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else {
                      _showErrorDialog(context);
                    }
                  },
                  child: Container(
                    height: 54,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF1E2851),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: const Center(
                      child: AutoSizeText(
                        "Se connecter",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Kabel-Bold',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
