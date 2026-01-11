import 'package:flutter/material.dart';
import '../game/logic_game.dart';

class GameBoardWidget extends StatelessWidget {
  final SnakeGame game;
  final Function(DragUpdateDetails) onSwipe;

  const GameBoardWidget({super.key, required this.game, required this.onSwipe});

  @override
  Widget build(BuildContext context) {
    final cellSize =
        MediaQuery.of(context).size.width / (SnakeGame.gridSize + 2);

    return GestureDetector(
      onPanUpdate: onSwipe,
      child: Container(
        width: cellSize * SnakeGame.gridSize,
        height: cellSize * SnakeGame.gridSize,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 145, 247, 150),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 164, 218, 169),
        ),
        child: Stack(
          children: [
            // Сетка игрового поля
            _buildGrid(cellSize),

            // Еда
            if (SnakeGame.food != null) _buildFood(cellSize),

            // Змейка
            ..._buildSnake(cellSize, game.snake),
          ],
        ),
      ),
    );
  }
}

Widget _buildGrid(double cellSize) {
  return Column(
    children: List.generate(
      SnakeGame.gridSize,
      (y) => Expanded(
        child: Row(
          children: List.generate(
            SnakeGame.gridSize,
            (x) => Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 46, 107, 48),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildFood(double cellSize) {
  final food = SnakeGame.food;
  if (food == null) return const SizedBox.shrink();
  return Positioned(
    left: SnakeGame.food!.x * cellSize,
    top: SnakeGame.food!.y * cellSize,
    child: Container(
      width: cellSize,
      height: cellSize,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(cellSize / 2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 235, 72, 60),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: const Icon(Icons.apple, color: Colors.white, size: 16),
    ),
  );
}

List<Widget> _buildSnake(double cellSize, List<Position> snake) {
  return List.generate(snake.length, (i) {
    return Positioned(
      left: snake[i].x * cellSize,
      top: snake[i].y * cellSize,
      child: Container(
        width: cellSize,
        height: cellSize,
        decoration: BoxDecoration(
          color: i == 0
              ? Colors.green[700]
              : const Color.fromARGB(255, 86, 218, 91),
          borderRadius: BorderRadius.circular(cellSize / 4),
          border: i == 0
              ? Border.all(
                  color: const Color.fromARGB(255, 33, 163, 41),
                  width: 2,
                )
              : Border.all(
                  color: const Color.fromARGB(255, 40, 136, 45),
                  width: 1,
                ),
        ),
      ),
    );
  });
}
