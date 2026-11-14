import 'package:flutter/material.dart';

/// アプリ全体で使う基本カラーパレット。
///
/// 「色を直接 Widget に書かない」のがデザインシステムの第一歩。
/// ここに集約しておくことで、後から一括で色を変えられる。
///
/// primary / surface / 文字色などは、[seed] から Material 3 の
/// `ColorScheme.fromSeed` が Light / Dark それぞれ自動生成する。
/// そのため、ここに持つのは「seed」と「ColorScheme に無い意味色」だけ。
/// コンポーネントからは直接参照せず、Theme 経由で使う（app_theme.dart 参照）。
class AppColors {
  AppColors._(); // インスタンス化させない（定数の集まりとして使う）

  /// ブランドのメインカラー。ColorScheme の seed に使う。
  static const Color seed = Color(0xFF4F6DF5);

  /// エラー色（Light）。Dark は seed から自動生成されるものを使う。
  static const Color error = Color(0xFFE5484D);

  // --- 成功（success）: ColorScheme に無いので自前で定義する ---
  static const Color successLight = Color(0xFF1B7A43);
  static const Color successContainerLight = Color(0xFFE3F5E9);
  static const Color onSuccessContainerLight = Color(0xFF0E4D29);
  static const Color successDark = Color(0xFF7BDA9C);
  static const Color onSuccessDark = Color(0xFF00391A);
  static const Color successContainerDark = Color(0xFF0F5229);
  static const Color onSuccessContainerDark = Color(0xFFBDF0CC);

  // --- 警告（warning） ---
  static const Color warningLight = Color(0xFF8A5A00);
  static const Color warningContainerLight = Color(0xFFFFF3DC);
  static const Color onWarningContainerLight = Color(0xFF5C3B00);
  static const Color warningDark = Color(0xFFF5C063);
  static const Color onWarningDark = Color(0xFF452B00);
  static const Color warningContainerDark = Color(0xFF634000);
  static const Color onWarningContainerDark = Color(0xFFFFE2B0);
}
