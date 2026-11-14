import 'package:flutter/material.dart';

/// セグメントの 1 つ分。[value] が選択値、[label] が表示名。
class AppSegment<T> {
  const AppSegment({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// iOS 風のトグル群（SegmentedButton）。
///
/// 設計方針:
/// - ジェネリクス `<T>` で任意の型を選択値にできる（enum でも String でも）。
/// - 状態（選択中の値）は親が持ち、[onChanged] で通知する（見た目は子・状態は親）。
/// - 複数選択ではなく「1 つだけ選ぶ」用途に絞っている。
class AppSegmentedButton<T> extends StatelessWidget {
  const AppSegmentedButton({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final List<AppSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: [
        for (final s in segments)
          ButtonSegment<T>(
            value: s.value,
            label: Text(s.label),
            icon: s.icon != null ? Icon(s.icon) : null,
          ),
      ],
      selected: {selected},
      onSelectionChanged: (set) => onChanged(set.first),
    );
  }
}
