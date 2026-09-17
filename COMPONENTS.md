# Neuma Kit Components

This document lists all components transferred from the main app to the neuma_kit package.

## Component Mapping

### Transferred to neuma_kit

| Original File | New Location | Notes |
|--------------|--------------|-------|
| `cater_app_bar.dart` | `src/layout/neuma_app_bar.dart` | Renamed class to `neumaAppBar` |
| `cater_background.dart` | `src/layout/neuma_background.dart` | Renamed classes to `neumaBackground` and `neumaBackgroundV2` |
| `cater_edge_to_edge_layout.dart` | `src/layout/neuma_edge_to_edge_layout.dart` | Renamed all classes with `neuma` prefix |
| `cater_page_padding.dart` | `src/layout/neuma_page_padding.dart` | Renamed class to `neumaPagePadding` |
| `cater_chip.dart` | `src/buttons/neuma_chip.dart` | Renamed class to `NeumaChip` |
| `cater_loading.dart` | `src/loading/neuma_loading.dart` | Renamed class to `neumaLoading` |
| `nav_badge.dart` | `src/badges/nav_badge.dart` | No rename, kept as `NavBadge` |
| `star_rating_input.dart` | `src/inputs/star_rating_input.dart` | No rename, kept as `StarRatingInput` |
| `thumbnail_fallback.dart` | `src/media/thumbnail_fallback.dart` | No rename, kept as `ThumbnailFallback` |

### New Components Created

| Component | Location | Purpose |
|-----------|----------|---------|
| `neumaBadge` | `src/badges/neuma_badge.dart` | Generic badge extracted from `_TempBadge` pattern |
| `neumaDivider` | `src/feedback/neuma_divider.dart` | Styled divider extracted from common pattern |
| `MetaInfoRow` | `src/layout/meta_info_row.dart` | Generic info row extracted from `_MetaRow` |
| `DotIndicator` | `src/navigation/dot_indicator.dart` | Carousel indicator extracted from announcement carousel |

### Business-Specific Components (NOT transferred)

These remain in the main app as they contain business logic:
- `membership_card.dart` - Contains tenant-specific data and logic
- `order_card.dart` - Order-specific business logic
- `order_menu_item_row.dart` - Menu item specifics
- `order_status_badge.dart` - Order status domain logic
- `notification_card.dart` - Notification domain logic
- All bottom sheets with complex flows
- All feature-specific widgets

## Package Structure

```
neuma_kit/
├── lib/
│   ├── neuma_kit.dart (barrel export)
│   └── src/
│       ├── badges/
│       │   ├── nav_badge.dart
│       │   └── neuma_badge.dart
│       ├── buttons/
│       │   └── neuma_chip.dart
│       ├── feedback/
│       │   └── neuma_divider.dart
│       ├── inputs/
│       │   └── star_rating_input.dart
│       ├── layout/
│       │   ├── meta_info_row.dart
│       │   ├── neuma_app_bar.dart
│       │   ├── neuma_background.dart
│       │   ├── neuma_edge_to_edge_layout.dart
│       │   └── neuma_page_padding.dart
│       ├── loading/
│       │   └── neuma_loading.dart
│       ├── media/
│       │   └── thumbnail_fallback.dart
│       └── navigation/
│           └── dot_indicator.dart
├── COMPONENTS.md (this file)
└── README.md
```

## Next Steps

1. **Update Dependencies**: Add all required dependencies to `neuma_kit/pubspec.yaml`
2. **Update Imports**: Update the main app to import from `neuma_kit` package
3. **Asset Migration**: Move Lottie animation files if they should be part of the package
4. **Testing**: Create example app or tests for each component
5. **Publish**: Set up git repo or pub.dev publishing

## Import Migration Guide

After setting up the package dependencies, update imports in your main app:

```dart
// Before
import 'package:food_catering_flutter/shared/widgets/cater_app_bar.dart';

// After
import 'package:neuma_kit/neuma_kit.dart';
```

And update class names:

```dart
// Before
CaterAppBar(title: Text('Title'))

// After
neumaAppBar(title: Text('Title'))
```
