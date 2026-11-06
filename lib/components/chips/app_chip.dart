import 'package:flutter/material.dart';

// NOTE: 完成版のコードは `main` ブランチにあります。詰まったら参照してください。

/// 選択状態を持てる共通チップ。
///
/// 設計方針:
/// - [selected] で「選択中／未選択」の見た目を切り替える。
/// - 状態（selected がどちらか）は親が持ち、[onSelected] で通知する。
///   コンポーネント自身は状態を持たない（＝ StatelessWidget）。
///   「見た目は子、状態は親」という責務分離の基本形。
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    // TODO(handson): FilterChip を使って実装する。
    //  - label / selected / onSelected をそのまま FilterChip に渡す
    return const Placeholder(fallbackHeight: 32, fallbackWidth: 80);
  }
}
