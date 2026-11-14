import 'package:flutter/material.dart';

/// アイコンだけのボタンの見た目。
enum AppIconButtonVariant {
  /// 塗りつぶし（IconButton.filled）。
  filled,

  /// 枠線のみ（IconButton.outlined）。
  outlined,

  /// 背景なし（標準の IconButton）。
  ghost,
}

/// アイコンのみの共通ボタン。
///
/// 設計方針:
/// - ラベルを持たないので、代わりに [tooltip] で意味を伝えられるようにする。
/// - [variant] で塗り／枠線／背景なしを切り替える。
/// - [onPressed] に null を渡すと無効（disabled）になる。
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.ghost,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon);

    return switch (variant) {
      AppIconButtonVariant.filled => IconButton.filled(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
      ),
      AppIconButtonVariant.outlined => IconButton.outlined(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
      ),
      AppIconButtonVariant.ghost => IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: iconWidget,
      ),
    };
  }
}
