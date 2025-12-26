import 'package:flutter/material.dart';
import 'package:snake_game/game/direction.dart';
import '../game/logic_game.dart';
import '../widgets/game_board_widget.dart';
import '../widgets/game_header_widget.dart';
import '../widgets/game_controls.dart';
import '../widgets/game_info_widget.dart';

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
    _game = SnakeGame(onUpdate: _upDateGame);
  }

  @override 
  void dispose() {
    _game.dispose();
    super.dispose();
  }

  void _upDateGame() {
    if (mounted) {
      setState (() {});
    }
  }

  void _handleSwipe(DragUpdateDetails details) {
    final delta = details.delta;
    if (delta.dx.abs() > delta.dy.abs()) {
      // Горизонтальное движение
      if (delta.dx > 0) {
        _game.changeDirection(Direction.right);
      } else {
        _game.changeDirection(Direction.left);
      }
    } else {
      // Вертикальное движение
      if (delta.dy > 0) {
        _game.changeDirection(Direction.down);
      } else {
        _game.changeDirection(Direction.up);
      }
    }
  }

  // Обработчик изменения направления из UI (кнопки)
  void _handleDirectionChange(Direction direction) {
    // Игнорируем ввод, если игра на паузе или уже окончена
    if (SnakeGame.isPaused || SnakeGame.isGameOver) return;
    _game.changeDirection(direction);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Заголовок и счет 
            const GameHeaderWidget(),

            const SizedBox(height: 20),

            // Игровое поле
            Center(
              child: GameBoardWidget(
                game: _game,
                onSwipe: _handleSwipe,
              ),
            ),

            const SizedBox(height: 20),

            // Информация о состоянии игры 
            const GameInfoWidget(),
            
            const SizedBox(height: 20),

            // Управление игрой 
            GameControls(
              onPauseResume: () => _game.togglePause(),
              onReset:  () => _game.reset(),
              onDirectionChange: _handleDirectionChange,
            ) 
          ],
        ),
      ),
    );
  }
}





