import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 余白の大きさ（AppSpacing に対応）。
enum AppGap { xs, sm, md, lg, xl }

/// 決まった大きさの余白を入れるための共通 Widget。
///
/// 設計方針:
/// - `SizedBox(height: 16)` のようなマジックナンバーを散らばらせず、
///   `AppSpacer(AppGap.md)` と「意味」で余白を指定できるようにする。
/// - 縦に使えば高さ、横に使えば幅の余白になる（Row/Column 両対応）。
class AppSpacer extends StatelessWidget {
  const AppSpacer(this.gap, {super.key});

  final AppGap gap;

  double get _size => switch (gap) {
    AppGap.xs => AppSpacing.xs,
    AppGap.sm => AppSpacing.sm,
    AppGap.md => AppSpacing.md,
    AppGap.lg => AppSpacing.lg,
    AppGap.xl => AppSpacing.xl,
  };

  @override
  Widget build(BuildContext context) {
    // 正方形の SizedBox。Column では高さ、Row では幅として効く。
    return SizedBox(width: _size, height: _size);
  }
}
