import 'package:flutter/material.dart';

/// 吹き出しを出す向き。
enum AppTooltipDirection { top, bottom }

/// 長押し／ホバーで説明を出す共通ツールチップ。
///
/// 設計方針:
/// - 子 Widget を「ラップする」タイプのコンポーネント。
///   `AppTooltip(message: '削除', child: AppIconButton(...))` のように包む。
/// - [direction] で吹き出しを上に出すか下に出すかを切り替える。
class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.direction = AppTooltipDirection.top,
  });

  final String message;
  final Widget child;
  final AppTooltipDirection direction;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      // preferBelow が true なら下、false なら上に出る。
      preferBelow: direction == AppTooltipDirection.bottom,
      child: child,
    );
  }
}
