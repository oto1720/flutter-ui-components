import 'package:flutter/material.dart';

/// バッジの種類。
enum AppBadgeType {
  /// 数値を表示する（通知件数など）。
  number,

  /// 小さな点だけ（未読マークなど）。
  dot,
}

/// 子 Widget の右上に付ける共通バッジ。
///
/// 設計方針:
/// - [child] に重ねる形で表示する（アイコンの右上など）。
/// - [type] が number のとき [count] を表示。0 以下なら非表示にする。
/// - 色は Theme の error（目を引く赤系）を使う。
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.child,
    this.type = AppBadgeType.number,
    this.count = 0,
  });

  final Widget child;
  final AppBadgeType type;
  final int count;

  @override
  Widget build(BuildContext context) {
    // number で 0 件なら、バッジを出さずに child だけ返す。
    if (type == AppBadgeType.number && count <= 0) {
      return child;
    }

    return Badge(
      label: type == AppBadgeType.number ? Text('$count') : null,
      // dot は小さな点。label を渡さなければ点だけになる。
      child: child,
    );
  }
}
