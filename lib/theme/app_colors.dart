import 'package:flutter/material.dart';

/// アプリ全体で使う基本カラーパレット。
///
/// 「色を直接 Widget に書かない」のがデザインシステムの第一歩。
/// ここに集約しておくことで、後から一括で色を変えられる。
class AppColors {
  AppColors._(); // インスタンス化させない（定数の集まりとして使う）

  /// ブランドのメインカラー。ColorScheme の seed にも使う。
  static const Color seed = Color(0xFF4F6DF5);

  static const Color primary = Color(0xFF4F6DF5);
  static const Color secondary = Color(0xFF7C8DB5);
  static const Color error = Color(0xFFE5484D);

  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF5A5F66);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF2F4F8);
  static const Color border = Color(0xFFD7DCE5);
}
