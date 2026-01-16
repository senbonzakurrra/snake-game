import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/routing/app_routes.dart';

class Records extends StatelessWidget {
  const Records({super.key});

  @override
  Widget build(BuildContext context) {
    final results = List.generate(
      10,
      (index) =>
          PlayerResults(name: 'Игрок ${index + 1}', score: (10 - index) * 100),
    );

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
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      title: Text(results[index].name),
                      subtitle: Text('${results[index].score} очков'),
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

class PlayerResults {
  final String name;
  final int score;

  PlayerResults({required this.name, required this.score});
}
