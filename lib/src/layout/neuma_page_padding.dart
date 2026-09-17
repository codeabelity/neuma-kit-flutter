import 'package:flutter/material.dart';

class NeumaPagePadding extends StatelessWidget {
  const NeumaPagePadding({
    required this.child,
    this.isHasBottomNav = true,
    super.key,
  });

  final Widget child;
  final bool isHasBottomNav;

  static const double horizontal = 16;
  static const double top = 96;
  static const double bottomBig = 120;
  static const double bottomSmall = 24;

  static const padding = EdgeInsets.fromLTRB(
    horizontal,
    top,
    horizontal,
    bottomSmall,
  );
  static const paddingWithBotNav = EdgeInsets.fromLTRB(
    horizontal,
    top,
    horizontal,
    bottomBig,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHasBottomNav ? padding : paddingWithBotNav,
      child: child,
    );
  }
}
