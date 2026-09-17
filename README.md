# Neuma Kit

A reusable Flutter UI component library featuring glassmorphic designs and modern UI patterns.

## Features

### Layout Components
- **neumaAppBar** - Glassmorphic app bar with gradient overlay
- **neumaBackground** / **neumaBackgroundV2** - Gradient background containers
- **neumaEdgeToEdgeLayout** - Complete edge-to-edge display solution for Android
- **neumaPagePadding** - Consistent page padding wrapper
- **MetaInfoRow** - Generic row for displaying metadata with icons

### Badges
- **NavBadge** - Animated navigation badge with ripple effect
- **neumaBadge** - Generic badge component for labels and tags

### Buttons
- **NeumaChip** - Action chip with icon + label (supports URIs)

### Inputs
- **StarRatingInput** - Interactive 5-star rating widget

### Loading
- **neumaLoading** - Customizable Lottie animation loader

### Feedback
- **neumaDivider** - Styled divider with consistent theming

### Media
- **ThumbnailFallback** - Placeholder for missing images

### Navigation
- **DotIndicator** - Page indicator for carousels

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  neuma_kit:
    path: ../neuma_kit  # Or use git/pub.dev once published
```

## Dependencies

This package requires:
- `liquid_glass_widgets` - For glassmorphic effects
- `phosphoricons_flutter` - For icons
- `lottie` - For loading animations
- `flutter_spinkit` - For badge animations
- `url_launcher` - For chip URI handling
- `gap` - For spacing
- `collection` - For utilities

## Usage

```dart
import 'package:neuma_kit/neuma_kit.dart';

// Use in your app
Scaffold(
  appBar: neumaAppBar(
    title: Text('My App'),
  ),
  body: neumaPagePadding(
    child: Column(
      children: [
        neumaBadge(label: 'New'),
        StarRatingInput(
          onRatingChanged: (rating) => print(rating),
        ),
      ],
    ),
  ),
)
```

## Customization

All widgets are theme-aware and respect your app's `ThemeData`. Most widgets accept customization parameters for colors, sizes, and behaviors.

## License

See LICENSE file for details.
