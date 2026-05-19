import 'package:flutter/material.dart';

import '../features/home/screens/home_screen.dart';
import '../features/math_speed/screens/math_speed_screen.dart';
import '../features/number_memory/screens/number_memory_screen.dart';
import '../features/reaction_test/screens/reaction_test_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String reactionTest = '/reaction-test';
  static const String mathSpeed = '/math-speed';
  static const String numberMemory = '/number-memory';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case reactionTest:
        return MaterialPageRoute(builder: (_) => const ReactionTestScreen());
      case mathSpeed:
        return MaterialPageRoute(builder: (_) => const MathSpeedScreen());
      case numberMemory:
        return MaterialPageRoute(builder: (_) => const NumberMemoryScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
