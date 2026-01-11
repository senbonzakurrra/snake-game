import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/game/direction.dart';
import 'package:snake_game/routing/app_routes.dart';
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
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Заголовок и счет
            const GameHeaderWidget(),

            // Игровое поле
            Center(
              child: GameBoardWidget(game: _game, onSwipe: _handleSwipe),
            ),

            // Информация о состоянии игры
            const GameInfoWidget(),

            const SizedBox(height: 100),

            // Управление игрой
            GameControls(
              onPauseResume: () => setState(() {
                _game.togglePause();
              }),
              onReset: () => setState(() {
                _game.reset();
              }),
            ),

            // Кнопка назад
            TextButton(
              onPressed: () {
                // Navigator.pop(context);
                context.goNamed(root);
              },
              child: Text("Назад"),
            ),
          ],
        ),
      ),
    );
  }
}
