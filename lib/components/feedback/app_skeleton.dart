import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 読み込み中のプレースホルダ（スケルトン）。
///
/// 設計方針:
/// - データ取得中に「コンテンツの形」だけを先に出し、点滅させて待ち時間を演出する。
/// - [AnimationController] で明るさを往復させるアニメーション入門の題材。
/// - StatefulWidget なのは「時間で変化する状態」を自分で持つため。
class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.radius = AppSpacing.radiusSm,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true); // 明→暗→明 を繰り返す

  @override
  void dispose() {
    _controller.dispose(); // リークしないよう必ず破棄する
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            // 透明度を往復させて「点滅」に見せる。
            color: base.withValues(alpha: 0.4 + _controller.value * 0.4),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        );
      },
    );
  }
}
