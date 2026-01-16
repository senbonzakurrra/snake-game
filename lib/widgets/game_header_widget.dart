import 'package:flutter/material.dart';
import 'package:snake_game/game/logic_game.dart';

class GameHeaderWidget extends StatelessWidget {
  const GameHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          _buildScoreWidget(),
        ],
      ),
    );
  }

  Widget _buildScoreWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 8),
          ValueListenableBuilder(
            valueListenable: SnakeGame.score,
            builder: (context, value, child) {
              return Text(
                '${SnakeGame.score.value}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
