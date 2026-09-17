import 'package:flutter/material.dart';

/// Generic badge component for labels, tags, or status indicators.
///
/// Displays a small pill-shaped badge with customizable colors, border, and text.
/// Useful for temporary indicators, status tags, or any small label.
class NeumaBadge extends StatelessWidget {
  const NeumaBadge({
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.fontSize = 10,
    this.paddingHorizontal = 6,
    this.paddingVertical = 2,
    this.fontWeight = FontWeight.w600,
    super.key,
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double fontSize;
  final double paddingHorizontal;
  final double paddingVertical;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {      
    final effectiveBackgroundColor = backgroundColor ?? 
        Colors.amber.withValues(alpha: 0.15);
    final effectiveBorderColor = borderColor ?? 
        Colors.amber.withValues(alpha: 0.4);
    final effectiveTextColor = textColor ?? Colors.amber.shade700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: effectiveBorderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: effectiveTextColor,
        ),
      ),
    );
  }
}
