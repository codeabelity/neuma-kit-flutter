import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// A [GlassAppBar] variant with a translucent black → transparent gradient
/// background that fades downward behind the bar content.
///
/// Drop-in replacement for [GlassAppBar] — accepts the same [title],
/// [leading], and [actions] parameters.
class neumaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const neumaAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  // Match GlassAppBar default height + status bar
  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.paddingOf(context).top;
    final totalHeight = preferredSize.height + statusBarHeight;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return Stack(
      children: [
        // Gradient backdrop — translucent black fading to transparent
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  surfaceColor,
                  surfaceColor.withAlpha(200),
                  surfaceColor.withAlpha(0),
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
        ),

        // Bar content — transparent so gradient shows through
        SizedBox(
          height: totalHeight,
          child: GlassAppBar(
            title: title,
            leading: leading,
            actions: actions,
            centerTitle: centerTitle,
          ),
        ),
      ],
    );
  }
}
