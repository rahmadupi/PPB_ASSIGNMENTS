import 'package:flutter/material.dart';

import 'views/home_screen.dart';

import 'widgets/neo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T3 W4 CRUD',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: NeoColors.canvas,
        colorScheme: const ColorScheme.light(
          primary: NeoColors.header,
          surface: NeoColors.canvas,
          onPrimary: Colors.black,
          onSurface: Colors.black,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w800),
          bodyMedium: TextStyle(fontWeight: FontWeight.w700),
        ),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
      ),
      home: const HomeScreen(),
    );
  }
}
