import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// アプリ全体のテーマ（Material 3）。
///
/// `MaterialApp(theme: AppTheme.light)` のように渡すと、
/// ここで決めた色・文字スタイルがアプリ全体に効く。
/// コンポーネント側では `Theme.of(context)` で参照できる。
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.surfaceVariant,
      textTheme: const TextTheme(
        headlineSmall: AppTextStyles.heading,
        titleMedium: AppTextStyles.title,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.label,
      ),
    );
  }
}
