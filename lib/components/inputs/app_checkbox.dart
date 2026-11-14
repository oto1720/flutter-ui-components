import 'package:flutter/material.dart';

/// ラベル付きの共通チェックボックス。
///
/// 設計方針:
/// - [value] と [onChanged] は必須。状態は親が持つ（StatelessWidget）。
/// - [onChanged] に null を渡すと無効（disabled）になる。
/// - ラベル部分をタップしても切り替わるよう、全体を 1 つの行として扱う。
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    // CheckboxListTile なら「チェック＋ラベル＋タップ領域」をまとめて扱える。
    return CheckboxListTile(
      value: value,
      // onChanged が null なら disabled。bool? を bool に詰め直して渡す。
      onChanged: onChanged == null ? null : (v) => onChanged!(v ?? false),
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
