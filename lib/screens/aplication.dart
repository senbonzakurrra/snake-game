import 'package:flutter/material.dart';
import 'package:snake_game/screens/main_menu.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(child: SafeArea(child: SimpleMenuScreen())),
    );
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
