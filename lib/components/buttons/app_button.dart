import 'package:flutter/material.dart';

// NOTE: 完成版のコードは `main` ブランチにあります。詰まったら参照してください。
//       このファイルはハンズオンの開始地点（TODO 雛形）です。

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
/// - [type] と [isLoading] は任意（デフォルトあり）。
/// - [onPressed] に null を渡すと「無効（disabled）」状態になる。
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
    // TODO(handson): ボタンを実装する。
    //  1. isLoading 中は onPressed を無効化し、CircularProgressIndicator を表示する
    //  2. type (primary/secondary/outlined) に応じて
    //     FilledButton / FilledButton.tonal / OutlinedButton を出し分ける
    //  3. 色は直書きせず Theme に任せ、角丸・余白は AppSpacing を使う
    return const Placeholder(fallbackHeight: 48);
  }
}
