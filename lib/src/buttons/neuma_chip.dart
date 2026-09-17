import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// ---------------------------------------------------------------------------
/// Contact chip — tappable button that opens a URI (tel / mailto / https)
/// ---------------------------------------------------------------------------
class NeumaChip extends StatelessWidget {
  const NeumaChip({
    required this.icon,
    required this.label,
    this.uri,
    this.onPressed,
    this.isDestructive = false,
    super.key,
  });

  final PhosphorDuotoneIconData icon;
  final String label;
  final Uri? uri;
  final VoidCallback? onPressed;
  final bool isDestructive;

  Future<void> _launch() async {
    if (uri != null) {
      await launchUrl(uri!, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final baseColor = isDestructive ? colorScheme.error : colorScheme.primary;
    final alpha = colorScheme.brightness == Brightness.light ? 0.15 : 0.25;
    final otherColor = baseColor.withValues(alpha: alpha);

    return InkWell(
      onTap: onPressed ?? _launch,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: otherColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: otherColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PhosphorIcon(icon, size: 16, color: baseColor),
            const Gap(6),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: baseColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
