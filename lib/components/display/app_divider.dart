import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 区切り線の向き。
enum AppDividerDirection { horizontal, vertical }

/// 共通の区切り線。
///
/// 設計方針:
/// - [direction] で横線／縦線を切り替える。縦線はメニューの区切りなどに使う。
/// - [inset] を true にすると左右に余白を入れる（リストの区切りでよく使う形）。
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.direction = AppDividerDirection.horizontal,
    this.inset = false,
  });

  final AppDividerDirection direction;
  final bool inset;

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case AppDividerDirection.horizontal:
        return Divider(
          height: AppSpacing.md,
          indent: inset ? AppSpacing.md : 0,
          endIndent: inset ? AppSpacing.md : 0,
        );
      case AppDividerDirection.vertical:
        return VerticalDivider(
          width: AppSpacing.md,
          indent: inset ? AppSpacing.sm : 0,
          endIndent: inset ? AppSpacing.sm : 0,
        );
    }
  }
}
