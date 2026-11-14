import 'package:flutter/material.dart';

/// 数値を範囲から選ぶ共通スライダー。
///
/// 設計方針:
/// - [value] と [onChanged] は必須。状態は親が持つ。
/// - [min] / [max] / [divisions] で「連続値」か「ステップ値」かを切り替える。
///   divisions を指定するとツマミが段階的に止まる。
/// - [label] を渡すと見出しを表示する（任意）。
class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.label,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final slider = Slider(
      value: value,
      min: min,
      max: max,
      divisions: divisions,
      // ツマミの上に出る吹き出し。ステップ値なら整数表示にする。
      label: divisions != null ? value.round().toString() : null,
      onChanged: onChanged,
    );

    if (label == null) return slider;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!, style: Theme.of(context).textTheme.labelLarge),
        slider,
      ],
    );
  }
}
