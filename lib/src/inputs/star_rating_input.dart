import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

/// Interactive 5-star rating input widget.
///
/// Allows users to select a rating from 1 to 5 stars by tapping.
/// Displays filled stars for selected rating and outlined stars for unselected.
class StarRatingInput extends StatefulWidget {
  const StarRatingInput({
    required this.onRatingChanged,
    this.initialRating = 0,
    this.starSize = 32,
    this.spacing = 4,
    super.key,
  });

  /// Callback when the rating changes. Value is 1-5, or 0 if unrated.
  final ValueChanged<int> onRatingChanged;

  /// Initial rating value (0-5). 0 means no rating selected.
  final int initialRating;

  /// Size of each star icon.
  final double starSize;

  /// Spacing between stars.
  final double spacing;

  @override
  State<StarRatingInput> createState() => _StarRatingInputState();
}

class _StarRatingInputState extends State<StarRatingInput> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _handleTap(int rating) {
    setState(() => _currentRating = rating);
    widget.onRatingChanged(rating);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= _currentRating;

        return GestureDetector(
          onTap: () => _handleTap(starValue),
          child: Padding(
            padding: EdgeInsets.only(
              right: index < 4 ? widget.spacing : 0,
            ),
            child: PhosphorIcon(
              isFilled ? PhosphorIconsFill.star : PhosphorIconsRegular.star,
              size: widget.starSize,
              color: isFilled ? Colors.amber : colorScheme.outlineVariant,
            ),
          ),
        );
      }),
    );
  }
}
