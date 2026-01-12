import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameStateWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<GameState> onGameStateChange;
  // final ValueChanged<bool> onFinished;
  const GameStateWidget({
    super.key,
    required this.child,
    required this.onGameStateChange,
    // required this.onFinished,
  });

  @override
  State<GameStateWidget> createState() => _GameStateWidgetState();
}

class _GameStateWidgetState extends State<GameStateWidget> {
  var _gameState = GameState.newGame;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [widget.child, SizedBox(height: 50), _buildBatton(context)],
    );
  }

  Widget _buildBatton(BuildContext context) {
    final text = switch (_gameState) {
      GameState.newGame => 'Начать',
      GameState.run => 'Пауза',
      GameState.paused => 'Продолжить',
      GameState.finished => 'В меню',
    };
    return ElevatedButton(onPressed: _changeState, child: Text(text));
  }

  void _changeState() {
    final newState = switch (_gameState) {
      GameState.newGame => GameState.run,
      GameState.run => GameState.paused,
      GameState.paused => GameState.run,
      GameState.finished => GameState.newGame,
    };
    setState(() {
      _gameState = newState;
      widget.onGameStateChange(_gameState);
    });
  }
}

enum GameState { newGame, run, paused, finished }
