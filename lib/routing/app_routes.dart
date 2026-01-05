import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snake_game/screens/aplication.dart';
import 'package:snake_game/screens/settings.dart';

const root = '/';
const settings = 'settings';

final GoRouter appRouter = GoRouter(
  initialLocation: root,
  routes: [
    GoRoute(
      path: root,
      builder: (context, state) => const Application(),
      routes: <RouteBase>[
        GoRoute(path: settings, builder: (context, state) => const Settings()),
      ],
    ),
  ],
);
