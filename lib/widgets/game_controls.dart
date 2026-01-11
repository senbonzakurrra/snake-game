import 'package:flutter/material.dart';
import 'package:snake_game/game/logic_game.dart';

class GameControls extends StatelessWidget {
  final VoidCallback onPauseResume;
  final VoidCallback onReset;

  const GameControls({
    super.key,
    required this.onPauseResume,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Кнопка паузы/продолжения
              ElevatedButton.icon(
                onPressed: onPauseResume,
                icon: Icon(SnakeGame.isPaused ? Icons.play_arrow : Icons.pause),
                label: Text(SnakeGame.isPaused ? 'Продолжить' : 'Пауза'),
              ),

              // Кнопка сброса
              ElevatedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.refresh),
                label: const Text('Новая игра'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
