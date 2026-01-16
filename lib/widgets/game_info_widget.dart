import 'package:flutter/material.dart';
import 'package:snake_game/game/logic_game.dart';
import 'package:snake_game/game/storage_adapter.dart';

class GameInfoWidget extends StatelessWidget {
  const GameInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: _getSnakeSpeed(),
        builder: (context, asyncSnapshot) {
          final speedText = asyncSnapshot.hasData ? asyncSnapshot.data : 0;
          return ValueListenableBuilder(
            valueListenable: SnakeGame.score,
            builder: (context, value, child) {
              return Text(
                SnakeGame.isGameOver
                    ? 'Игра окончена. Ваш счет: ${SnakeGame.score.value}'
                    : SnakeGame.isPaused
                    ? 'Игра на паузе'
                    : 'Скорость $speedText',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: SnakeGame.isGameOver
                      ? Colors.red
                      : SnakeGame.isPaused
                      ? Colors.brown
                      : Colors.green,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<double> _getSnakeSpeed() async {
    return StorageAdapter.getSpeed();
  }
}
