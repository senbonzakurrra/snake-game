import 'package:flutter/material.dart';
import 'package:snake_game/images.dart';
import 'package:snake_game/screens/game_screen.dart';

class SimpleMenuScreen extends StatelessWidget {
  const SimpleMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Основное меню')),
      body: Center(
        child: Stack(
          children: [
            AppImages.logoImage(width: 1000, height: 500),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Навигация к экрану игры
                      final route = MaterialPageRoute<void>(
                        builder: (context) {
                          return const GameBoard();
                        },
                      );
                      Navigator.of(context).push(route);
                    },
                    child: const Text('Начало игры'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Навигация к настройкам
                    },
                    child: const Text('Настройки'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Простая кнопка рекорды
  // ignore: unused_element
  Container _buildScoreButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () {
          // Навигация к экрану рекордов
        },
        child: const Text('Рекорды'),
      ),
    );
  }
}
