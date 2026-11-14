import 'package:flutter/material.dart';

/// 引っ張って更新（Pull to Refresh）を付ける共通ラッパー。
///
/// 設計方針:
/// - スクロールできる [child] を包むだけで、上に引っ張ると更新が走る。
/// - [onRefresh] は `Future` を返す非同期関数。Future が完了するまで
///   インジケータが回り続ける（更新完了のタイミングを Flutter に伝えられる）。
class AppPullToRefresh extends StatelessWidget {
  const AppPullToRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }
}
