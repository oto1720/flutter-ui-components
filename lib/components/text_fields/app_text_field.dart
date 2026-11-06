import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// アプリ共通のテキスト入力フィールド。
///
/// 設計方針:
/// - [label] は必須。何を入力する欄かは必ず示す。
/// - [errorText] に文字列を入れると「エラー表示」になる（null ならエラーなし）。
///   状態を bool ではなく「エラーメッセージの有無」で表すと、
///   表示する文言もまとめて扱えて分かりやすい。
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
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        errorText: errorText, // null ならエラー表示されない
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
      ),
    );
  }
}
