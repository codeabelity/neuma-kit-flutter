import 'package:flutter/material.dart';

class neumaBackground extends StatelessWidget {
  const neumaBackground({required this.colorScheme, this.child, super.key});

  final ColorScheme colorScheme;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surface.withValues(alpha: 0.95),
            colorScheme.surface.withValues(alpha: 0.9),
            colorScheme.surface.withValues(alpha: 0.85),
          ],
        ),
      ),
      child: child,
    );
  }
}

class neumaBackgroundV2 extends StatelessWidget {
  const neumaBackgroundV2({required this.colorScheme, this.child, super.key});

  final ColorScheme colorScheme;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final topColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.6)
        : const Color.fromARGB(170, 229, 255, 240);
    final bottomColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.4)
        : const Color.fromARGB(130, 229, 255, 240);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            topColor,
            colorScheme.surface,
            bottomColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
