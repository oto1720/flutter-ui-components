import 'package:flutter/material.dart';

import '../buttons/app_button.dart';

/// 押すと少し縮む、アニメーション付きのボタン。
///
/// 設計方針:
/// - 以前は GestureDetector + Container で一から自作していたが、
///   それだとリップル・フォーカス・読み上げ・サイズや色の切り替えを
///   すべて作り直すことになる。
/// - そこで「押した感触」を [AppButton] の `animatePress` オプションに統合し、
///   この Widget はそれを有効にするだけの薄いラッパーにしている。
///   「似た部品を増やすより、既存の部品にオプションを足す」という例。
/// - 縮むアニメーションの実装は app_button.dart の `_PressScale` を参照。
class AppAnimatedButton extends StatelessWidget {
  const AppAnimatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.tone = AppButtonTone.primary,
    this.size = AppButtonSize.md,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonTone tone;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      variant: variant,
      tone: tone,
      size: size,
      animatePress: true,
    );
  }
}
