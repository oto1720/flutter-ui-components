import 'package:flutter/material.dart';

/// アプリ全体で使う基本カラーパレット（ミニマル・モノクロ版）。
///
/// このテーマの色の考え方:
/// - 基本は「黒・白・灰」だけ。色数を絞ると、写真や内容そのものが主役になる。
/// - 目を引かせたい所にだけ [accent] を 1 色使う（FAB・進捗・カーソルなど）。
///   アクセントを 1 色に絞るのが、落ち着いた印象を作るコツ。
/// - 成功・警告・エラーは「意味を伝える色」なので、モノクロでも色を残す。
///
/// コンポーネントからは直接参照せず、Theme 経由で使う（app_theme.dart 参照）。
class AppColors {
  AppColors._(); // インスタンス化させない（定数の集まりとして使う）

  // --- 黒〜白のグレースケール（数字が大きいほど暗い） ---
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFF0F0F0);
  static const Color gray150 = Color(0xFFE9E9E9);
  static const Color gray200 = Color(0xFFE2E2E2);
  static const Color gray300 = Color(0xFFCFCFCF);
  static const Color gray400 = Color(0xFFA6A6A6);
  static const Color gray600 = Color(0xFF6B6B6B);
  static const Color gray700 = Color(0xFF3D3D3D);
  static const Color gray800 = Color(0xFF2A2A2A);
  static const Color gray850 = Color(0xFF1F1F1F);
  static const Color gray900 = Color(0xFF171717);
  static const Color gray950 = Color(0xFF0C0C0C);

  /// 文字や主要ボタンに使う「ほぼ黒」。真っ黒 (#000) より少し柔らかい。
  static const Color ink = Color(0xFF111111);

  // --- アクセント（1 色だけ） ---
  static const Color accentLight = Color(0xFFFF5A1F);
  static const Color accentContainerLight = Color(0xFFFFE8DE);
  static const Color onAccentContainerLight = Color(0xFF7A2400);
  static const Color accentDark = Color(0xFFFF7A45);
  static const Color accentContainerDark = Color(0xFF5C1E00);
  static const Color onAccentContainerDark = Color(0xFFFFDCCB);

  // --- エラー ---
  static const Color errorLight = Color(0xFFD92D32);
  static const Color errorContainerLight = Color(0xFFFDE8E8);
  static const Color onErrorContainerLight = Color(0xFF8C1D21);
  static const Color errorDark = Color(0xFFFF7B7E);
  static const Color onErrorDark = Color(0xFF4A0507);
  static const Color errorContainerDark = Color(0xFF6E1418);
  static const Color onErrorContainerDark = Color(0xFFFFDADA);

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
