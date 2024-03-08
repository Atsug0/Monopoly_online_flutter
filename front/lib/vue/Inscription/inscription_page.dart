import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/navigator_key.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  bool _isObscured =
      true; // Variable pour suivre l'état de l'obfuscation du texte

  Color isEmailValid(String email) {
    // Expression régulière pour valider un email
    if (email.isEmpty) {
      return Colors.white;
    }
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email) ? Colors.green : Colors.red;
  }

  bool isEmailValid2(String email) {
    // Expression régulière pour valider un email
    if (email.isEmpty) {
      return false;
    }
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  Color isPasswordValid(String password) {
    // Vérifier si le mot de passe contient au moins 1 majuscule, 1 minuscule, 1 caractère spécial et 1 chiffre, et a une longueur minimale de 8 caractères
    if (password.isEmpty) {
      return Colors.white;
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+={}\[\]|;:"<>,./?\\]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password) ? Colors.green : Colors.red;
  }

  bool isPasswordValid2(String password) {
    // Vérifier si le mot de passe contient au moins 1 majuscule, 1 minuscule, 1 caractère spécial et 1 chiffre, et a une longueur minimale de 8 caractères
    if (password.isEmpty) {
      return false;
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+={}\[\]|;:"<>,./?\\]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: AutoSizeText(
                "T'inscire te permettra de visualiser en temps\nréel différente statistique lié à tes parties",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Kabel-Bold',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white),
                maxLines: 2,
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
                    border: Border.all(
                        width: 1,
                        color: _textEditingController.text.isEmpty
                            ? Colors.white
                            : Colors.green)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (String val) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: 'Entrez votre pseudo',
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
                          counterText:
                              '', // Pour masquer le compteur de caractères
                          counterStyle: TextStyle(
                              fontSize:
                                  0), // Pour réduire l'espace occupé par le compteur
                          // Limiter la longueur maximale à 6 caractères
                          counter: Offstage(),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 54,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF1E2851),
                    border: Border.all(
                        width: 1,
                        color: isEmailValid(_textEditingController2.text))),
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
                          hintText: 'Entrez votre email',
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
                        keyboardType: TextInputType.emailAddress,
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
                    border: Border.all(
                        width: 1,
                        color: isPasswordValid(_textEditingController3.text))),
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
                          hintText: 'Entrez un mot de passe',
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
                          // Limiter la longueur maximale à 6 caractères
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    containsUpperCase(_textEditingController3.text)
                        ? Icons.check
                        : Icons.close,
                    color: containsUpperCase(_textEditingController3.text)
                        ? Colors.green
                        : Colors.red),
                AutoSizeText(
                  "Contient une majuscule",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Kabel-Bold',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: containsUpperCase(_textEditingController3.text)
                          ? Colors.green
                          : Colors.red),
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    containsLowerCase(_textEditingController3.text)
                        ? Icons.check
                        : Icons.close,
                    color: containsLowerCase(_textEditingController3.text)
                        ? Colors.green
                        : Colors.red),
                AutoSizeText(
                  "Contient une minuscule",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Kabel-Bold',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: containsLowerCase(_textEditingController3.text)
                          ? Colors.green
                          : Colors.red),
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    containsDigit(_textEditingController3.text)
                        ? Icons.check
                        : Icons.close,
                    color: containsDigit(_textEditingController3.text)
                        ? Colors.green
                        : Colors.red),
                AutoSizeText(
                  "Contient un chiffre",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Kabel-Bold',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: containsDigit(_textEditingController3.text)
                          ? Colors.green
                          : Colors.red),
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    containsSpecialCharacter(_textEditingController3.text)
                        ? Icons.check
                        : Icons.close,
                    color:
                        containsSpecialCharacter(_textEditingController3.text)
                            ? Colors.green
                            : Colors.red),
                AutoSizeText(
                  "Contient un carractère spéciale",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Kabel-Bold',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color:
                          containsSpecialCharacter(_textEditingController3.text)
                              ? Colors.green
                              : Colors.red),
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    hasMinLength(_textEditingController3.text, 8)
                        ? Icons.check
                        : Icons.close,
                    color: hasMinLength(_textEditingController3.text, 8)
                        ? Colors.green
                        : Colors.red),
                AutoSizeText(
                  "Contient minimum 8 caractères",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Kabel-Bold',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: hasMinLength(_textEditingController3.text, 8)
                          ? Colors.green
                          : Colors.red),
                  maxLines: 1,
                ),
              ],
            ),
            if (_textEditingController.text.isNotEmpty &&
                isEmailValid2(_textEditingController2.text) &&
                isPasswordValid2(_textEditingController3.text))
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    //faire l essai de connection
                    JsManager.jsmanager.createUser(
                        _textEditingController.text,
                        _textEditingController2.text,
                        _textEditingController3.text);
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
                        "S'inscrire",
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

  // Vérifie si la chaîne contient au moins une majuscule
  bool containsUpperCase(String str) {
    return str.contains(RegExp(r'[A-Z]'));
  }

// Vérifie si la chaîne contient au moins une minuscule
  bool containsLowerCase(String str) {
    return str.contains(RegExp(r'[a-z]'));
  }

// Vérifie si la chaîne contient au moins un caractère spécial
  bool containsSpecialCharacter(String str) {
    return str.contains(RegExp(r'[!@#$%^&*()_+={}\[\]|;:"<>,./?\\]'));
  }

// Vérifie si la chaîne contient au moins un chiffre
  bool containsDigit(String str) {
    return str.contains(RegExp(r'[0-9]'));
  }

// Vérifie si la longueur de la chaîne est d'au moins 8 caractères
  bool hasMinLength(String str, int minLength) {
    return str.length >= minLength;
  }
}
