import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/routing/app_routes.dart';

class GameStateWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<GameState> onGameStateChange;
  final ValueNotifier<bool> onFinished;
  const GameStateWidget({
    super.key,
    required this.child,
    required this.onGameStateChange,
    required this.onFinished,
  });

  @override
  State<GameStateWidget> createState() => _GameStateWidgetState();
}

class _GameStateWidgetState extends State<GameStateWidget> {
  final ValueNotifier<GameState> _gameState = ValueNotifier(GameState.newGame);

  @override
  void initState() {
    super.initState();
    widget.onFinished.addListener(() {
      if (widget.onFinished.value) {
        setState(() {
          _gameState.value = GameState.finished;
          widget.onGameStateChange(_gameState.value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [widget.child, SizedBox(height: 50), _buildBatton(context)],
    );
  }

  Widget _buildBatton(BuildContext context) {
    return ElevatedButton(
      onPressed: _gameState.value == GameState.finished
          ? _toMainMenu
          : _changeState,
      child: ValueListenableBuilder(
        valueListenable: _gameState,
        builder: (context, value, _) {
          final text = switch (value) {
            GameState.newGame => 'Начать',
            GameState.run => 'Пауза',
            GameState.paused => 'Продолжить',
            GameState.finished => 'В меню',
          };
          return Text(text);
        },
      ),
    );
  }

  void _changeState() {
    final newState = switch (_gameState.value) {
      GameState.newGame => GameState.run,
      GameState.run => GameState.paused,
      GameState.paused => GameState.run,
      GameState.finished => GameState.newGame,
    };

    widget.onGameStateChange(newState);
  }

  void _toMainMenu() {
    context.goNamed(root);
  }
}

enum GameState { newGame, run, paused, finished }
