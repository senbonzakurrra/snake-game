import 'package:flutter/material.dart';
import '../game/logic_game.dart';
import '../game/direction.dart';

// Виджет игрового поля
class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late SnakeGame _game;

  @override
  void initState() {
    super.initState();
    _game = SnakeGame(onUpdate: _updateGame);
  }

  // Метод обновления состояния
  void _updateGame() {
    if (mounted) {
      setState(() {});
    }
  }

  // Обработка нажатий клавиш/кнопок
  // ignore: unused_element
  void _handleKeyPress(Direction direction) {
    _game.changeDirection(direction);
  }

  // Обработка свайпов
  void handleSwipe(DragUpdateDetails details) {
    // ignore: unused_local_variable
    final dx = details.delta.dx;
    // ignore: unused_local_variable
    final dy = details.delta.dy;
  }

  // Определение направления по свайпу
  // if (dx.abs() > dy.abs()) {
  // Горизонтальный свайп
  // if (dx > 0) {
  // _handleKeyPress(Direction.right);
  // } else {
  // _handleKeyPress(Direction.left);
  //}
  //} else {
  // Вертикальный свайп
  //if (dy > 0) {
  // _handleKeyPress(Direction.down);
  //} else {
  // _handleKeyPress(Direction.up);
  // }
  //}

  @override
  Widget build(BuildContext context) {
    final cellSize =
        MediaQuery.of(context).size.width / (SnakeGame.gridSize + 2);

    // Игровое поле
    GestureDetector(
      onPanUpdate: handleSwipe,
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
            Column(
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
            ),

            // Еда (яблоко)
            if (SnakeGame.food != null)
              Positioned(
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
              ),

            // Змейка
            for (int i = 0; 1 < _game.snake.length; i++)
              Positioned(
                left: _game.snake[i].x * cellSize,
                top: _game.snake[i].y * cellSize,
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
              ),
          ],
        ),
      ),
    );

    // Состояние игры
    Padding(
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

    // Кнопки управления игрой
    // Padding(
    //  padding: const EdgeInsets.all(16.0),
    //  child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //    children: []
    // Кнопка паузы/продолжения
    // ElevatedButton.icon(
    //  onPressed: () => ,
    // )
    // ),
    // )

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Заголовок и счет
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Змейка',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 15, 104, 19),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Кушайте яблоки, избегайте стен и себя',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${SnakeGame.score}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
