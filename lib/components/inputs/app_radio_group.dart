import 'package:flutter/material.dart';

/// ラジオボタンの選択肢 1 つ分。
class AppRadioOption<T> {
  const AppRadioOption({required this.value, required this.label});

  final T value;
  final String label;
}

/// 「複数から 1 つだけ選ぶ」ラジオボタングループ。
///
/// 設計方針:
/// - ジェネリクス `<T>` で任意の型を選択値にできる。
/// - `value` / `groupValue` パターン: 各行の値と「今選ばれている値」を比べて
///   選択状態を決める。状態（groupValue）は親が持ち、[onChanged] で通知する。
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  final List<AppRadioOption<T>> options;
  final T? groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    // 新しい API では「今選ばれている値」と「変更通知」を RadioGroup が束ね、
    // 各 RadioListTile は自分の value を持つだけでよい。
    return RadioGroup<T>(
      groupValue: groupValue,
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final option in options)
            RadioListTile<T>(
              value: option.value,
              title: Text(option.label),
              contentPadding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}
