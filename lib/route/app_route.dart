import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser_demo/screen/form_screen.dart';
import 'package:keyboard_dismisser_demo/screen/result_screen.dart';

class AppRoute {
  final String home = '/';

  final String resultScreen = '/ResultScreen';

  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRoute().home,
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage();
        },
      ),
      GoRoute(
        path: AppRoute().resultScreen,
        builder: (BuildContext context, GoRouterState state) {
          return ResultScreen(
            arguments: state.extra,
          );
        },
      ),
    ],
  );
}
