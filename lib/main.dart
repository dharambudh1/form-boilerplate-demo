import 'package:flutter/material.dart';
import 'package:keyboard_dismisser_demo/route/app_route.dart';
import 'package:keyboard_dismisser_demo/util/keyboard_dismisser.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: AppRoute.router.routerDelegate,
        routeInformationParser: AppRoute.router.routeInformationParser,
        routeInformationProvider: AppRoute.router.routeInformationProvider,
      ),
    );
  }
}
