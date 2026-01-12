import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/routing/app_routes.dart';

class Records extends StatelessWidget {
  const Records({super.key});

  @override
  Widget build(BuildContext context) {
    final scores = [300, 250, 200, 150, 100, 60, 40, 20];
    final names = [
      'Игрок 1',
      'Игрок 2',
      'Игрок 3',
      'Игрок 4',
      'Игрок 5',
      'Игрок 6',
      'Игрок 7',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Таблица рекордов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(root);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Лучшие результаты',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Таблица рекордов
            Expanded(
              child: ListView.builder(
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      title: Text(names[index]),
                      subtitle: Text('${scores[index]} очков'),
                      trailing: Icon(
                        index < 3 ? Icons.star : Icons.emoji_events_outlined,
                        color: index < 3 ? Colors.amber : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Кнопка назад
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.goNamed(root);
              },
              child: const Text('Вернуться в меню'),
            ),
          ],
        ),
      ),
    );
  }
}
