import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_semantic_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// アプリ全体のテーマ（Material 3）。
///
/// `MaterialApp(theme: AppTheme.light, darkTheme: AppTheme.dark)` のように渡すと、
/// ここで決めた色・文字スタイル・部品の形がアプリ全体に効く。
/// コンポーネント側では `Theme.of(context)` で参照できる。
///
/// ポイントは「部品別テーマ」（inputDecorationTheme / cardTheme など）。
/// 角丸や塗りをここで 1 回決めておけば、各コンポーネントで同じ指定を
/// 繰り返さずに済み、標準の Widget を直接使った箇所も同じ見た目に揃う。
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
      // Dark の error は seed から自動生成される色（暗い背景向け）を使う。
      error: isLight ? AppColors.error : null,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    );
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLow,
      // 色は持たせず、大きさ・太さだけ上書きする（色は ColorScheme から付く）。
      textTheme: const TextTheme(
        headlineSmall: AppTextStyles.heading,
        titleMedium: AppTextStyles.title,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.label,
      ),
      // ColorScheme に無い success / warning を Theme に追加する。
      extensions: [isLight ? AppSemanticColors.light : AppSemanticColors.dark],

      // ---- 部品別テーマ ----
      // 入力欄（TextField / Dropdown / DatePicker など）の共通の見た目。
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: inputBorder,
      ),
      // ボタンの角丸。AppButton を通さない標準ボタン（ダイアログ内など）も揃う。
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: buttonShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(shape: buttonShape),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: buttonShape),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: buttonShape),
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
      ),
    );
  }
}
