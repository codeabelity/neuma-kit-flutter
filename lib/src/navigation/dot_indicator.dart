import 'package:flutter/material.dart';

/// Dot indicator for carousels and paginated content.
///
/// Displays a row of dots where the current page is highlighted.
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    required this.count,
    required this.current,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8,
    this.spacing = 6,
    super.key,
  });

  /// Total number of dots to display.
  final int count;

  /// Index of the currently active dot (0-indexed).
  final int current;

  /// Color for the active dot. Defaults to theme primary color.
  final Color? activeColor;

  /// Color for inactive dots. Defaults to theme outline variant.
  final Color? inactiveColor;

  /// Size (diameter) of each dot.
  final double dotSize;

  /// Spacing between dots.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveActiveColor = activeColor ?? colorScheme.primary;
    final effectiveInactiveColor = inactiveColor ?? 
        colorScheme.outlineVariant.withValues(alpha: 0.5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return Container(
          margin: EdgeInsets.only(right: index < count - 1 ? spacing : 0),
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? effectiveActiveColor : effectiveInactiveColor,
          ),
        );
      }),
    );
  }
}
