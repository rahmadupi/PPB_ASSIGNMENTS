import 'package:flutter/material.dart';

import '../shared/theme/neubrutal_theme.dart';
import 'app_routes.dart';

class HumanBenchmarkApp extends StatelessWidget {
  const HumanBenchmarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Human Benchmark Mini Games',
      theme: NeubrutalTheme.light(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
