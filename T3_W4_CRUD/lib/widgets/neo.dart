import 'package:flutter/material.dart';

class NeoColors {
  static const header = Color(0xFF00E5FF); // cyan
  static const cell = Color(0xFFFFEB3B); // yellow
  static const selected = Color(0xFFFF1744); // red
  static const button = Color(0xFF00E676); // green
  static const canvas = Color(0xFFF5F5F5);

  static const border = Colors.black;
}

class Neo {
  static const borderWidth = 3.0;
  static const shadowOffset = Offset(4, 4);

  static BoxDecoration box({required Color color, bool selected = false}) {
    return BoxDecoration(
      color: selected ? NeoColors.selected : color,
      border: Border.all(color: NeoColors.border, width: borderWidth),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          offset: shadowOffset,
          blurRadius: 0,
          spreadRadius: 0,
        ),
      ],
    );
  }

  static TextStyle titleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.w800,
      color: Colors.black,
    );
  }

  static TextStyle bodyBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }
}

class NeoBox extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final bool selected;

  const NeoBox({
    super.key,
    required this.color,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: Neo.box(color: color, selected: selected),
      child: child,
    );
  }
}

class NeoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const NeoButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: NeoBox(
        color: NeoColors.button,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Text(text, style: Neo.bodyBold(context)),
      ),
    );
  }
}
