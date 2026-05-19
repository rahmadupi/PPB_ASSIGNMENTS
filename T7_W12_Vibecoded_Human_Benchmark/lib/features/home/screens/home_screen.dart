import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../models/home_nav_item.dart';
import '../widgets/home_nav_card.dart';
import '../../../shared/theme/neubrutal_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<HomeNavItem> _navItems = [
    HomeNavItem(
      title: 'Reaction Time',
      subtitle: 'Test your reflex speed',
      badge: 'FAST',
      color: NeubrutalTheme.accent,
      routeName: AppRoutes.reactionTest,
      icon: Icons.arrow_forward,
    ),
    HomeNavItem(
      title: 'Math Speed',
      subtitle: 'Solve as many as you can in 30 seconds',
      badge: 'SPEED',
      color: NeubrutalTheme.accentThree,
      routeName: AppRoutes.mathSpeed,
      icon: Icons.arrow_forward,
    ),
    HomeNavItem(
      title: 'Number Memory',
      subtitle: 'Remember longer numbers each round',
      badge: 'MEM',
      color: NeubrutalTheme.accentTwo,
      routeName: AppRoutes.numberMemory,
      icon: Icons.arrow_forward,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Human Benchmark Mini Games')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Train your brain. Break your limits.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: NeubrutalTheme.cardDecoration(
              color: NeubrutalTheme.accentTwo,
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Pick a game to start. Results compare you to your past runs.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (final item in _navItems) ...[
            HomeNavCard(
              title: item.title,
              subtitle: item.subtitle,
              badge: item.badge,
              color: item.color,
              icon: item.icon,
              onTap: () => Navigator.of(context).pushNamed(item.routeName),
            ),
            if (item != _navItems.last) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
