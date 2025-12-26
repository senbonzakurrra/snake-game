import 'package:flutter/material.dart';
import 'package:snake_game/game/direction.dart';
import '../game/logic_game.dart';

class GameControls extends StatelessWidget {
 final VoidCallback onPauseResume;
 final VoidCallback onReset;
 final Function(Direction) onDirectionChange;

  const GameControls({
    super.key,
    required this.onPauseResume,
    required this.onReset,
    required this.onDirectionChange,
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
                icon: Icon(
                  SnakeGame.isPaused ? Icons.play_arrow : Icons.pause,
                ),
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
          
          const SizedBox(height: 20),
          
          // Кнопки управления направлением
          _buildDirectionControls(),
        ],
      ),
    );
  }

  Widget _buildDirectionControls() {
    return Column(
      children: [
        // Вверх
        IconButton(
          onPressed: () => onDirectionChange(Direction.up),
          icon: const Icon(Icons.keyboard_arrow_up, size: 40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Влево
            IconButton(
              onPressed: () => onDirectionChange(Direction.left),
              icon: const Icon(Icons.keyboard_arrow_left, size: 40),
            ),
            const SizedBox(width: 60),
            // Вправо
            IconButton(
              onPressed: () => onDirectionChange(Direction.right),
              icon: const Icon(Icons.keyboard_arrow_right, size: 40),
            ),
          ],
        ),
        // Вниз
        IconButton(
          onPressed: () => onDirectionChange(Direction.down),
          icon: const Icon(Icons.keyboard_arrow_down, size: 40),
        ),
      ],
    );
  }
}
