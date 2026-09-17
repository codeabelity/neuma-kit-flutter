import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A comprehensive solution for handling edge-to-edge display and system UI
/// insets on all Android versions, with special focus on Android 15+ changes
class NeumaEdgeToEdgeLayout {
  static bool _isInitialized = false;

  /// Initialize edge-to-edge mode for the entire app
  /// Call this in main() before runApp()
  static Future<void> initialize() async {
    if (_isInitialized || !Platform.isAndroid) return;

    WidgetsFlutterBinding.ensureInitialized();

    // Enable edge-to-edge mode
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Set transparent system bars
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    _isInitialized = true;
  }

  /// Get safe area padding for manual calculations
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.paddingOf(context);
  }

  /// Get view insets (keyboard, etc.)
  static EdgeInsets getViewInsets(BuildContext context) {
    return MediaQuery.viewInsetsOf(context);
  }

  /// Check if device has gesture navigation
  static bool hasGestureNavigation(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    // Gesture navigation typically has bottom padding > 20
    return padding.bottom > 20;
  }

  /// Get navigation bar height
  static double getNavigationBarHeight(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return padding.bottom;
  }

  /// Get status bar height
  static double getStatusBarHeight(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return padding.top;
  }
}

/// A widget that automatically handles system UI insets and provides
/// safe area for content while maintaining edge-to-edge appearance
class NeumaEdgeToEdgeScaffold extends StatelessWidget {
  const NeumaEdgeToEdgeScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.extendBody = true,
    this.extendBodyBehindAppBar = true,
    this.resizeToAvoidBottomInset = true,
    this.maintainBottomViewPadding = false,
    this.customPadding,
  });
  final Widget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final bool maintainBottomViewPadding;
  final EdgeInsets? customPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: appBar != null ? _buildAppBar(context) : null,
      body: NeumaSafeAreaWrapper(
        customPadding: customPadding,
        maintainBottomViewPadding: maintainBottomViewPadding,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar != null
          ? NeumaSafeAreaWrapper(
              applyTop: false,
              applyLeft: false,
              applyRight: false,
              child: bottomNavigationBar!,
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final statusBarHeight = NeumaEdgeToEdgeLayout.getStatusBarHeight(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + statusBarHeight),
      child: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: appBar,
      ),
    );
  }
}

/// A wrapper widget that applies safe area padding intelligently
class NeumaSafeAreaWrapper extends StatelessWidget {
  const NeumaSafeAreaWrapper({
    required this.child,
    super.key,
    this.applyTop = true,
    this.applyBottom = true,
    this.applyLeft = true,
    this.applyRight = true,
    this.customPadding,
    this.maintainBottomViewPadding = false,
  });
  final Widget child;
  final bool applyTop;
  final bool applyBottom;
  final bool applyLeft;
  final bool applyRight;
  final EdgeInsets? customPadding;
  final bool maintainBottomViewPadding;

  @override
  Widget build(BuildContext context) {
    if (customPadding != null) {
      return Padding(padding: customPadding!, child: child);
    }

    return SafeArea(
      top: applyTop,
      bottom: applyBottom,
      left: applyLeft,
      right: applyRight,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: child,
    );
  }
}

/// A custom app bar that handles edge-to-edge display properly
class NeumaEdgeToEdgeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NeumaEdgeToEdgeAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.elevation,
    this.foregroundColor,
    this.centerTitle = false,
  });
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final double? elevation;
  final Color? foregroundColor;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: backgroundColor ?? theme.colorScheme.primary,
      child: SafeArea(
        bottom: false,
        child: AppBar(
          title:
              titleWidget ??
              (title != null
                  ? Text(title!, style: theme.textTheme.headlineMedium)
                  : null),
          actions: actions,
          leading: automaticallyImplyLeading
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          elevation: elevation ?? 8,
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          centerTitle: centerTitle,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// A bottom navigation bar that handles edge-to-edge display
class NeumaEdgeToEdgeBottomNavigationBar extends StatelessWidget {
  const NeumaEdgeToEdgeBottomNavigationBar({
    required this.items,
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.type = BottomNavigationBarType.fixed,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final BottomNavigationBarType type;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          backgroundColor ??
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          type: type,
          showSelectedLabels: showSelectedLabels,
          showUnselectedLabels: showUnselectedLabels,
          elevation: 0,
        ),
      ),
    );
  }
}

/// A utility widget for custom content that needs manual inset handling
class NeumaEdgeToEdgeContent extends StatelessWidget {
  const NeumaEdgeToEdgeContent({
    required this.child,
    super.key,
    this.avoidStatusBar = true,
    this.avoidNavigationBar = true,
    this.avoidKeyboard = true,
    this.additionalPadding,
  });
  final Widget child;
  final bool avoidStatusBar;
  final bool avoidNavigationBar;
  final bool avoidKeyboard;
  final EdgeInsets? additionalPadding;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safePadding = mediaQuery.padding;
    final viewInsets = mediaQuery.viewInsets;

    var padding = EdgeInsets.zero;

    if (avoidStatusBar) {
      padding = padding.copyWith(top: safePadding.top);
    }

    if (avoidNavigationBar) {
      padding = padding.copyWith(
        left: safePadding.left,
        right: safePadding.right,
        bottom: safePadding.bottom,
      );
    }

    if (avoidKeyboard) {
      padding = padding.copyWith(bottom: padding.bottom + viewInsets.bottom);
    }

    if (additionalPadding != null) {
      padding = EdgeInsets.fromLTRB(
        padding.left + additionalPadding!.left,
        padding.top + additionalPadding!.top,
        padding.right + additionalPadding!.right,
        padding.bottom + additionalPadding!.bottom,
      );
    }

    return Padding(padding: padding, child: child);
  }
}

/// Extension methods for easier usage
extension NeumaEdgeToEdgeExtensions on BuildContext {
  EdgeInsets get safeAreaPadding =>
      NeumaEdgeToEdgeLayout.getSafeAreaPadding(this);
  EdgeInsets get viewInsets => NeumaEdgeToEdgeLayout.getViewInsets(this);
  bool get hasGestureNavigation =>
      NeumaEdgeToEdgeLayout.hasGestureNavigation(this);
  double get navigationBarHeight =>
      NeumaEdgeToEdgeLayout.getNavigationBarHeight(this);
  double get statusBarHeight => NeumaEdgeToEdgeLayout.getStatusBarHeight(this);
}

/// Example usage and helper methods
class EdgeToEdgeExamples {
  /// Example of a basic screen implementation
  static Widget basicScreen({required Widget content}) {
    return NeumaEdgeToEdgeScaffold(
      appBar: const NeumaEdgeToEdgeAppBar(title: 'Example Screen'),
      body: content,
    );
  }

  /// Example of a screen with bottom navigation
  static Widget screenWithBottomNav({
    required Widget content,
    required List<BottomNavigationBarItem> navItems,
    int currentIndex = 0,
    ValueChanged<int>? onNavTap,
  }) {
    return NeumaEdgeToEdgeScaffold(
      body: content,
      bottomNavigationBar: NeumaEdgeToEdgeBottomNavigationBar(
        items: navItems,
        currentIndex: currentIndex,
        onTap: onNavTap,
      ),
    );
  }

  /// Example of a full-screen content (like video player)
  static Widget fullScreenContent({required Widget content}) {
    return NeumaEdgeToEdgeScaffold(
      body: NeumaEdgeToEdgeContent(
        avoidStatusBar: false,
        avoidNavigationBar: false,
        child: content,
      ),
    );
  }
}
