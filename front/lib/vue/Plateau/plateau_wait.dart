import 'package:flutter/material.dart';
import 'package:monopoly/controller/game_manager.dart';
import 'package:monopoly/vue/Plateau/plateau.dart';

class MonopolyBoardAsync extends StatefulWidget {
  const MonopolyBoardAsync({Key? key}) : super(key: key);

  @override
  State<MonopolyBoardAsync> createState() => _MonopolyBoardAsyncState();
}

class _MonopolyBoardAsyncState extends State<MonopolyBoardAsync> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initAsync();
  }

  Future<void> _initAsync() async {
    await GameManager.cardManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Une erreur s\'est produite'),
          );
        } else {
          return const MonopolyBoard();
        }
      },
    );
  }
}
