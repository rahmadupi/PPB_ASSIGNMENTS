import 'package:flutter/material.dart';

import '../../../shared/theme/neubrutal_theme.dart';

class HomeNavCard extends StatelessWidget {
  const HomeNavCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String badge;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: NeubrutalTheme.cardDecoration(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: NeubrutalTheme.cardDecoration(color: color),
                child: Text(
                  badge,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: NeubrutalTheme.cardDecoration(
                  color: NeubrutalTheme.accent,
                ),
                child: Icon(icon, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
