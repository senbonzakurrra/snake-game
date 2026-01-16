import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'direction.dart';

// Позиция на игровом поле
class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  // Создание копии с возможными изминениями
  Position copywith({int? x, int? y}) {
    return Position(x ?? this.x, y ?? this.y);
  }
}

// Класс игры Змейка
class SnakeGame {
  // Размер игрового поля (в ячейках)
  static const int gridSize = 40;

  // Змейка (список позиций)
  List<Position> snake = [];

  // Еда (яблоко)
  static Position? food;

  // Текущее направление
  Direction nextDirection = Direction.right;

  // Таймер для обновления игры
  Timer? gameTimer;

  // Игровая скорость (обновлений в секунду)
  static double gameSpeed = 2;

  // Игровой счет
  static ValueNotifier<int> score = ValueNotifier(0);

  // Состояние игры
  static bool isGameOver = false;
  final ValueNotifier<bool> gameFinished = ValueNotifier(false);
  static bool isPaused = false;

  // Callback для обновления UI
  final VoidCallback onUpdate;

  // Констуктор
  SnakeGame({required this.onUpdate});

  // Начало новой игры
  void startNewGame() {
    // Остановка предыдущего таймера
    gameTimer?.cancel();

    // Сброс состояния
    snake = [
      Position(gridSize ~/ 2, gridSize ~/ 2),
      Position((gridSize ~/ 2) - 1, gridSize ~/ 2),
      Position((gridSize ~/ 2) - 2, gridSize ~/ 2),
    ];

    score.value = 0;
    nextDirection = Direction.right;
    isGameOver = false;
    isPaused = false;

    // Генерация первой еды
    generateFood();

    // Запуск игрового цикла
    startGameLoop();
  }

  // Запуск нового цикла
  void startGameLoop() {
    gameTimer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ gameSpeed),
      (_) => updateGame(),
    );
  }

  // Обновление состояния игры
  void updateGame() {
    if (isGameOver || isPaused) return;

    // Обновление направления
    Direction currentDirection = nextDirection;

    // Вычисление новой головы змейки
    Position head = snake.first;
    Position newHead;

    switch (currentDirection) {
      case Direction.up:
        newHead = Position(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Position(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Position(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Position(head.x + 1, head.y);
        break;
    }

    // Проверка столковени со стенами
    if (newHead.x < 0 ||
        newHead.x >= gridSize ||
        newHead.y < 0 ||
        newHead.y >= gridSize) {
      gameOver();
      return;
    }

    // Проверка столкновения с собой
    if (snake.contains(newHead)) {
      gameOver();
      return;
    }

    // Добавление новой головы
    snake.insert(0, newHead);

    // Проверка съедения еды
    if (food != null && newHead == food!) {
      // Увеличение счета
      score.value += 10;
    }

    // Увеличение скорости каждые 50 очков
    if (score.value % 50 == 0 && gameSpeed < 20) {
      gameSpeed++;
      gameTimer?.cancel();
      startGameLoop();
    }

    // Проверяем, съела ли змейка еду
    if (snake[0].x == food!.x && snake[0].y == food!.y) {
      // Змейка съела еду
      generateFood(); // Генерация новой еды
      // Не удаляем хвост - змейка растёт
    } else {
      // Еда не съедена - удаляем хвост для движения
      snake.removeLast();
    }

    // Уведомление UI об обновлении
    onUpdate();
  }

  // Генерация еды на поле
  void generateFood() {
    final random = Random();

    Position newFood;
    bool foodOnSnake;

    do {
      foodOnSnake = false;
      newFood = Position(random.nextInt(gridSize), random.nextInt(gridSize));

      // Проверка, что еда не появилась на змейке
      for (var segment in snake) {
        if (segment == newFood) {
          foodOnSnake = true;
          break;
        }
      }
    } while (foodOnSnake);

    food = newFood;
  }

  // Обработка окончания игры
  void gameOver() {
    isGameOver = true;
    gameTimer?.cancel();
    onUpdate();
    gameFinished.value = true;
  }

  // Управление направлением змейки
  void changeDirection(Direction newDirection) {
    // Не позволяем змейке развернуться на 180 градусов
    if (!nextDirection.isOpposite(newDirection)) {
      nextDirection = newDirection;
    }
  }

  // Пауза/возобновление игры
  void togglePause() {
    isPaused = !isPaused;

    if (isPaused) {
      gameTimer?.cancel();
    } else {
      startGameLoop();
    }
  }

  // Сброс игры к начальному состоянию
  void reset() {
    // Остановка текущего цикла и запуск новой игры
    gameTimer?.cancel();
    startNewGame();
    // Обновление UI
    onUpdate();
  }

  // Алиас для совместимости с UI
  void onReset() => reset();

  // Освобождение ресурсов
  void dispose() {
    gameTimer?.cancel();
  }

  // Устаревший заглушечный метод (оставлен для совместимости)
  void dis() {}
}
