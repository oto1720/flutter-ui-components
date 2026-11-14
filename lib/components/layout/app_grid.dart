import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 画面幅に応じて列数が変わる共通グリッド（レスポンシブ）。
///
/// 設計方針:
/// - 列数を固定で持たず、[maxCrossAxisExtent]（1 マスの最大幅）を決めると、
///   幅が広い画面では自動的に列が増える。スマホ／タブレットで作り分けずに済む。
/// - 余白は AppSpacing を使う。スクロールは親に任せられるよう shrinkWrap。
class AppGrid extends StatelessWidget {
  const AppGrid({
    super.key,
    required this.children,
    this.maxItemWidth = 180,
    this.aspectRatio = 1,
  });

  final List<Widget> children;
  final double maxItemWidth;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: maxItemWidth,
      childAspectRatio: aspectRatio,
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      children: children,
    );
  }
}
