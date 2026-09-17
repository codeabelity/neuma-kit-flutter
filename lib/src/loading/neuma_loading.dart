import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Shared loading widget that plays a branded Lottie animation.
///
/// The animation contains a fork, knife, two rectangles, and a circle pulse.
/// By default all solid-fill layers are recolored to [ColorScheme.primary].
///
/// **Note:** This widget requires a Lottie animation file at the specified path.
/// You'll need to provide your own animation or update the asset path.
///
/// Usage:
/// ```dart
/// // Themed (default)
/// neumaLoading()
///
/// // Slower playback (0.5 = half speed, 2.0 = double speed)
/// neumaLoading(speed: 0.5)
///
/// // Custom size and color
/// neumaLoading(size: 80, color: Colors.white)
/// ```
class neumaLoading extends StatefulWidget {
  const neumaLoading({
    super.key,
    this.size = 48,
    this.color,
    this.speed = 0.9,
    this.assetPath = 'assets/lotties/loading.lottie',
  });

  /// Width and height of the animation square.
  final double size;

  /// Color applied to all solid-fill and stroke vector layers.
  /// Defaults to [ColorScheme.primary] when null.
  final Color? color;

  /// Playback speed multiplier. 1.0 is normal, 0.5 is half speed, etc.
  final double speed;

  /// Path to the Lottie animation asset.
  final String assetPath;

  @override
  State<neumaLoading> createState() => _neumaLoadingState();
}

class _neumaLoadingState extends State<neumaLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // ---------------------------------------------------------------------------
  // Layer paths extracted from animations/12345.json inside loading.lottie
  // Update these based on your actual Lottie file structure
  // ---------------------------------------------------------------------------
  static const _circleFill = ['Livello forma 9', 'Ellisse 1', 'Riempimento 1'];
  static const _forkFill = ['forchetta contorni', 'Gruppo 1', 'Riempimento 1'];
  static const _knifeFill = ['coltello contorni', 'Gruppo 1', 'Riempimento 1'];
  static const _rect1Fill = [
    'Livello forma 1',
    'Rettangolo 1',
    'Riempimento 1',
  ];
  static const _rect1Stroke = ['Livello forma 1', 'Rettangolo 1', 'Traccia 1'];
  static const _rect2Fill = [
    'Livello forma 2',
    'Rettangolo 1',
    'Riempimento 1',
  ];
  static const _rect2Stroke = ['Livello forma 2', 'Rettangolo 1', 'Traccia 1'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = widget.color ?? colorScheme.primary;
    final foregroundColor = colorScheme.onSurface;

    return Lottie.asset(
      widget.assetPath,
      width: widget.size,
      height: widget.size,
      fit: BoxFit.contain,
      controller: _controller,
      decoder: _dotLottieDecoder,
      onLoaded: (composition) {
        // Scale duration by the inverse of speed to slow down or speed up.
        _controller.duration = composition.duration * (1 / widget.speed);
        _controller.repeat();
      },
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(
            _circleFill,
            value: backgroundColor,
          ),
          ValueDelegate.color(_forkFill, value: foregroundColor),
          ValueDelegate.color(_knifeFill, value: foregroundColor),
          ValueDelegate.color(_rect1Fill, value: foregroundColor),
          ValueDelegate.strokeColor(_rect1Stroke, value: foregroundColor),
          ValueDelegate.color(_rect2Fill, value: foregroundColor),
          ValueDelegate.strokeColor(_rect2Stroke, value: foregroundColor),
        ],
      ),
    );
  }
}

/// Decoder for the dotLottie (.lottie) binary format.
/// Picks the first animation JSON inside the ZIP archive.
Future<LottieComposition?> _dotLottieDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(
    bytes,
    filePicker: (files) => files.firstWhereOrNull(
      (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
    ),
  );
}
