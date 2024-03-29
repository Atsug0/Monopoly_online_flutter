import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monopoly/controller/navigator_key.dart';
import 'package:monopoly/vue/Connection/connection_page.dart';
import 'package:monopoly/vue/HomePage/home_page.dart';
import 'package:monopoly/vue/Inscription/inscription_page.dart';
import 'package:monopoly/vue/Lobby/connect_lobby.dart';
import 'package:monopoly/vue/Lobby/create_loby.dart';
import 'package:monopoly/vue/Plateau/plateau.dart';
import 'package:monopoly/vue/Plateau/plateau_wait.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: "/",
        routes: {
          "/": (context) => const HomePage(),
          "plateau": (context) => const MonopolyBoardAsync(),
          "lobby": (context) => const Lobby(),
          "connectLobby": (context) => const ConnectToLobby(),
          "inscription": (context) => const InscriptionPage(),
          "connexion": (context) => const ConnexionPage(),
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
