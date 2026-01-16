import 'package:flutter/material.dart';
import 'package:snake_game/game/direction.dart';
import 'package:snake_game/game/logic_game.dart';
import 'package:snake_game/widgets/game_board_widget.dart';
import 'package:snake_game/widgets/game_header_widget.dart';
import 'package:snake_game/widgets/game_info_widget.dart';
import 'package:snake_game/widgets/game_state_widget.dart';

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
    _game.reset();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Заголовок и счет
            const GameHeaderWidget(),

            // Игровое поле
            GameStateWidget(
              onFinished: _game.gameFinished,
              onGameStateChange: (value) {
                setState(() {
                  switch (value) {
                    case GameState.run:
                      if (SnakeGame.isPaused) {
                        _game.togglePause();
                      } else {
                        _game.startNewGame();
                      }
                    case GameState.paused:
                      _game.togglePause();
                    case GameState.finished:
                      break;

                    case GameState.newGame:
                      break;
                  }
                });
              },
              child: Center(
                child: GameBoardWidget(game: _game, onSwipe: _handleSwipe),
              ),
            ),

            // Информация о состоянии игры
            const GameInfoWidget(),
          ],
        ),
      ),
    );
  }
}
