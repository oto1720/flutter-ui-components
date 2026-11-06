import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// ボタンの種類。
///
/// 「色違い・形違いのボタンを別々の Widget にする」のではなく、
/// 1 つのコンポーネントに enum でバリエーションを持たせるのが設計のポイント。
/// 使う側は `AppButton(type: AppButtonType.secondary, ...)` と書くだけ。
enum AppButtonType { primary, secondary, outlined }

/// アプリ共通のボタン。
///
/// 設計方針:
/// - [label] と [onPressed] は必須（required）。ボタンの本質なので省略させない。
/// - [type] と [isLoading] は任意（デフォルトあり）。バリエーションは任意指定。
/// - [onPressed] に null を渡すと「無効（disabled）」状態になる。
///   これは Flutter 標準ボタンの慣習に合わせている。
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // ローディング中は押せないようにする（onPressed を無効化）。
    final effectiveOnPressed = isLoading ? null : onPressed;

    // ローディング中はスピナー、それ以外はラベルを表示する。
    final child = isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    );
    const padding = EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    );

    // type によって使う Flutter 標準ボタンを切り替える。
    // 色は Theme（ColorScheme）から取るので、ここに色を直書きしない。
    switch (type) {
      case AppButtonType.primary:
        return FilledButton(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(shape: shape, padding: padding),
          child: child,
        );
      case AppButtonType.secondary:
        return FilledButton.tonal(
          onPressed: effectiveOnPressed,
          style: FilledButton.styleFrom(shape: shape, padding: padding),
          child: child,
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(shape: shape, padding: padding),
          child: child,
        );
    }
  }
}
