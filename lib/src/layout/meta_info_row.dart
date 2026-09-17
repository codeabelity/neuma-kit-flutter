import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

/// Generic meta information row component with icon, content, and optional trailing widget.
///
/// Useful for displaying structured information with consistent styling across the app.
/// Commonly used for addresses, dates, times, notes, and other metadata.
class MetaInfoRow extends StatelessWidget {
  const MetaInfoRow({
    required this.icon,
    required this.child,
    this.trailing,
    this.height = 22,
    this.iconSize = 14,
    super.key,
  });

  final PhosphorDuotoneIconData icon;
  final Widget child;
  final Widget? trailing;
  final double height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      child: Row(
        children: [
          PhosphorIcon(
            icon,
            size: iconSize,
            color: colorScheme.onSurfaceVariant,
          ),
          const Gap(4),
          Expanded(child: child),
          if (trailing != null) ...[
            const Gap(4),
            trailing!,
          ],
        ],
      ),
    );
  }
}
