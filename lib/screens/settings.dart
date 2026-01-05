import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/routing/app_routes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Navigator.pop(context);
          context.goNamed(root);
        },
        child: Text("Назад"),
      ),
    );
  }
}
