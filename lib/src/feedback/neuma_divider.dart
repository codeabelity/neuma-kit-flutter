import 'package:flutter/material.dart';

/// Styled divider with consistent appearance across the app.
///
/// Uses theme colors with reduced opacity for a subtle separation effect.
class NeumaDivider extends StatelessWidget {
  const NeumaDivider({
    this.height = 1,
    this.thickness = 1,
    this.alpha = 0.4,
    this.indent = 0,
    this.endIndent = 0,
    super.key,
  });

  final double height;
  final double thickness;
  final double alpha;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: colorScheme.outlineVariant.withValues(alpha: alpha),
    );
  }
}
