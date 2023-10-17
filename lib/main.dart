import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'mb_game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MBGame game = MBGame();
  runApp(MyApp(game:game));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.game});
  final MBGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GameWidget(game: game)
    );
  }
}
