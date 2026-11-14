import 'package:flutter/material.dart';

/// ドロップダウンの選択肢 1 つ分。
class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label});

  final T value;
  final String label;
}

/// 選択肢から 1 つ選ぶ共通ドロップダウン。
///
/// 設計方針:
/// - ジェネリクス `<T>` で任意の型を選択値にできる。
/// - [value]（現在値）は親が持ち、[onChanged] で通知する。
/// - [label] は何を選ぶ欄かを示す見出し（AppTextField と揃える）。
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
  });

  final String label;
  final List<AppDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      onChanged: onChanged,
      hint: hintText != null ? Text(hintText!) : null,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: [
        for (final item in items)
          DropdownMenuItem<T>(value: item.value, child: Text(item.label)),
      ],
    );
  }
}
