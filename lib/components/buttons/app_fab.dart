import 'package:flutter/material.dart';

/// FloatingActionButton の種類。
enum AppFabType {
  /// 標準サイズ。
  regular,

  /// 小さいサイズ。
  small,

  /// ラベル付きの横長（extended）。
  extended,
}

/// アプリ共通の FloatingActionButton ラッパー。
///
/// 設計方針:
/// - [type] が extended のときだけ [label] が必要。
///   「extended なのに label が無い」のを防ぐため、build 内で assert する。
/// - 色は Theme に任せる。
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.type = AppFabType.regular,
    this.label,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppFabType type;

  /// extended のときに表示するラベル。
  final String? label;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppFabType.regular:
        return FloatingActionButton(
          onPressed: onPressed,
          tooltip: tooltip,
          child: Icon(icon),
        );
      case AppFabType.small:
        return FloatingActionButton.small(
          onPressed: onPressed,
          tooltip: tooltip,
          child: Icon(icon),
        );
      case AppFabType.extended:
        assert(label != null, 'extended の AppFab には label が必要です');
        return FloatingActionButton.extended(
          onPressed: onPressed,
          tooltip: tooltip,
          icon: Icon(icon),
          label: Text(label ?? ''),
        );
    }
  }
}
