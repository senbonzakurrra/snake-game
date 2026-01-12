import 'package:go_router/go_router.dart';
import 'package:snake_game/screens/game_screen.dart';
import 'package:snake_game/screens/main_menu.dart';
import 'package:snake_game/screens/records.dart';
import 'package:snake_game/screens/settings.dart';

const root = '/';
const settings = 'settings';
const game = 'game';
const records = 'records';

final GoRouter appRouter = GoRouter(
  initialLocation: root,
  routes: [
    GoRoute(
      path: root,
      name: root,
      builder: (context, state) => const SimpleMenuScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: settings,
          name: settings,
          builder: (context, state) => const Settings(),
        ),
        GoRoute(
          path: game,
          name: game,
          builder: (context, state) => const GameBoard(),
        ),
        GoRoute(
          path: records,
          name: records,
          builder: (context, state) => const Records(),
        ),
      ],
    ),
  ],
);
