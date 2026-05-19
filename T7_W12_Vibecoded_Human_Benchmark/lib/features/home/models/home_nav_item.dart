import 'package:flutter/material.dart';

class HomeNavItem {
  const HomeNavItem({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.color,
    required this.routeName,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String badge;
  final Color color;
  final String routeName;
  final IconData icon;
}
