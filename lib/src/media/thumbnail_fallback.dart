import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

/// Shared thumbnail fallback widget used across features when no image is available.
/// 
/// Shows an icon on a tinted background with rounded corners.
class ThumbnailFallback extends StatelessWidget {
  const ThumbnailFallback({
    required this.icon,
    this.size = 56,
    this.iconSize = 24,
    this.borderRadius = 8,
    super.key,
  });

  final PhosphorDuotoneIconData icon;
  final double size;
  final double iconSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: size,
        height: size,
        color: colorScheme.primaryFixed,
        child: Center(
          child: PhosphorIcon(
            icon,
            size: iconSize,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
