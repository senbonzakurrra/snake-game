import 'package:flutter/material.dart';
import 'package:snake_game/routing/app_routes.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouter);
  }

  // ignore: unused_element
  Widget _buildLogo() {
    return const Text('Logo first');
  }

  // ignore: unused_element
  Widget _buildLogoSecond() {
    return const Text('Logo second');
  }

  void main() {
    runApp(const Application());
  }
}
