import 'package:flutter/material.dart';
import 'package:snake_game/game/logic_game.dart';

class GameInfoWidget extends StatelessWidget {
  const GameInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        SnakeGame.isGameOver
            ? 'Игра окончена. Ваш счет: ${SnakeGame.score}'
            : SnakeGame.isPaused
            ? 'Игра на паузе'
            : 'Скорость ${SnakeGame.gameSpeed}',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: SnakeGame.isGameOver
              ? Colors.red
              : SnakeGame.isPaused
              ? Colors.brown
              : Colors.green,
        ),
      ),
    );
  }
}
