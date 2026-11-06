import 'package:flutter/material.dart';

// NOTE: 完成版のコードは `main` ブランチにあります。詰まったら参照してください。

/// アプリ共通のテキスト入力フィールド。
///
/// 設計方針:
/// - [label] は必須。何を入力する欄かは必ず示す。
/// - [errorText] に文字列を入れると「エラー表示」になる（null ならエラーなし）。
/// - [obscureText] を true にするとパスワード入力欄になる。
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.errorText,
    this.obscureText = false,
    this.onChanged,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    // TODO(handson): TextField を使って入力欄を実装する。
    //  - InputDecoration に labelText / hintText / errorText を渡す
    //  - obscureText を TextField に渡してパスワード入力に対応する
    //  - border を OutlineInputBorder にして角丸は AppSpacing を使う
    return const Placeholder(fallbackHeight: 56);
  }
}
