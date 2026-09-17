import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// A nav-bar icon with an animated ripple badge overlaid at the top-right.
///
/// - Pass a [count] > 0 to show a numbered badge (capped at 99+).
/// - Pass [count] == 0 (or null) with [showDot] == true for a plain dot badge
///   (useful when you have unread items but no specific count to show).
/// - The ripple animation plays only when the badge is visible.
class NavBadge extends StatelessWidget {
  const NavBadge({
    required this.icon,
    this.count,
    this.showDot = false,
    super.key,
  });

  /// The base icon widget.
  final Widget icon;

  /// Number to display in the badge. When null or 0 the badge is hidden
  /// unless [showDot] is true.
  final int? count;

  /// Show a plain dot badge (no number). Ignored when [count] > 0.
  final bool showDot;

  bool get _visible => (count != null && count! > 0) || showDot;
  bool get _numbered => count != null && count! > 0;

  String get _label {
    if (!_numbered) return '';
    return count! > 99 ? '99+' : '$count';
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final labelStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: onPrimary,
      fontWeight: FontWeight.w800,
      height: 1,
    );

    if (!_visible) return icon;

    // Badge size: numbered badges are slightly larger than dot badges.
    final badgeSize = _numbered ? 16.0 : 8.0;
    final containerSize = _numbered ? 28.0 : 16.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        Positioned(
          top: -8,
          right: _numbered ? -14 : -6,
          child: SizedBox(
            width: containerSize,
            height: containerSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ripple ring — only when there is something to show.
                SpinKitRipple(
                  color: primary,
                  size: containerSize,
                  duration: const Duration(seconds: 2),
                ),
                // Badge pill / dot.
                Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primary.withAlpha(170),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: _numbered ? Text(_label, style: labelStyle) : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
