import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game/fruit_catcher_game.dart';
import 'game/managers/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager().initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FruitCatcherGame game;

  @override
  void initState() {
    super.initState();
    game = FruitCatcherGame();
  }

  @override
  void dispose() {
    game.onRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game),
            Positioned(
              top: 50,
              left: 20,
              child: ValueListenableBuilder<int>(
                valueListenable: game.scoreNotifier,
                builder: (context, score, _) {
                  return Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.music_note, color: Colors.black),
                    onPressed: () {
                      AudioManager().toggleMusic();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.black),
                    onPressed: () {
                      AudioManager().toggleSfx();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
