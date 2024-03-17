import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/js_controller.dart';
import 'package:monopoly/controller/navigator_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AutoSizeText(
              "Mono Paul Hi !",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Kabel-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  color: Colors.white),
              maxLines: 2,
            ),
            if (JsManager.jsmanager.isConnected)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed("lobby").then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 54,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF1E2851),
                    ),
                    child: const Center(
                      child: AutoSizeText(
                        "Crée un lobby",
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
            if (JsManager.jsmanager.isConnected)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState
                        ?.pushNamed("connectLobby")
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 54,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF1E2851),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          "Rejoindre un lobby",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Kabel-Bold',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  print(JsManager.jsmanager.isConnected);
                },
                child: Container(
                  height: 54,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF1E2851),
                  ),
                  child: const Center(
                    child: AutoSizeText(
                      "A propos",
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
            if (!JsManager.jsmanager.isConnected)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState
                        ?.pushNamed("inscription")
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 54,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF1E2851),
                    ),
                    child: const Center(
                      child: AutoSizeText(
                        "Inscription",
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
            if (!JsManager.jsmanager.isConnected)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState
                        ?.pushNamed("connexion")
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 54,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF1E2851),
                    ),
                    child: const Center(
                      child: AutoSizeText(
                        "Connexion",
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
          ],
        ),
      ),
    );
  }
}
