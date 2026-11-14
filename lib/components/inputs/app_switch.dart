import 'package:flutter/material.dart';

/// ラベル付きの共通スイッチ（ON / OFF トグル）。
///
/// 設計方針:
/// - [value] と [onChanged] は必須。状態は親が持つ。
/// - [onChanged] に null を渡すと無効（disabled）になる。
/// - チェックボックスと作りを揃え、使う側が迷わないようにしている。
class AppSwitch extends StatelessWidget {
  const AppSwitch({
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
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(label),
      contentPadding: EdgeInsets.zero,
    );
  }
}
