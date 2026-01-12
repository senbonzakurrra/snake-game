import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/game/storage_adapter.dart';
import 'package:snake_game/routing/app_routes.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Начальное значение скорости
  double snakeSpeed = 2;

  // Минимальная и максимальная скорость
  final double minSpeed = 1;
  final double maxSpeed = 3;

  // Количество делений на ползунке
  final int _divisions = 2;

  // Метки для значений скорости
  final Map<double, String> speedLabels = {
    1: 'Медленно',
    2: 'Нормально',
    3: 'Быстро',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getSpeed();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Заголовок
          const Text(
            'Настройки скорости змейки',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Ползунок для настройки скорости
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Slider(
              value: snakeSpeed,
              min: minSpeed,
              max: maxSpeed,
              divisions: _divisions,
              label: '${snakeSpeed.toStringAsFixed(1)}x',
              onChanged: (double value) {
                setState(() {
                  snakeSpeed = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Медленно',
                  style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
                Text(
                  'Нормально',
                  style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
                Text(
                  'Быстро',
                  style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Кнопки
          Column(
            children: [
              // Кнопка сохранения
              ElevatedButton(
                onPressed: () {
                  StorageAdapter.setSpeed(snakeSpeed);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Настройки сохранены'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text('Сохранить скорость'),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  context.goNamed(root);
                },
                child: Text("Назад"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getSpeed() async {
    snakeSpeed = await StorageAdapter.getSpeed();
    setState(() {});
  }
}
