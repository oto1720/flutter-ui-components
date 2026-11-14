import 'package:flutter/material.dart';

import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';

/// スナックバーの種類（意味で指定する）。
enum AppSnackbarType { success, error, info }

/// 画面下部に短いメッセージを出す共通スナックバー。
///
/// 設計方針:
/// - Widget ではなく「呼び出すためのヘルパー」として提供する。
///   `AppSnackbar.show(context, 'ログインしました')` のように使う。
/// - [type] に応じてアイコンと色を切り替える。色は Theme を基にする。
class AppSnackbar {
  AppSnackbar._();

  static void show(
    BuildContext context,
    String message, {
    AppSnackbarType type = AppSnackbarType.info,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final semantic = AppSemanticColors.of(context);
    // (アイコン, 背景色, その上の文字色)
    final (icon, color, onColor) = switch (type) {
      AppSnackbarType.success => (
        Icons.check_circle,
        semantic.success,
        semantic.onSuccess,
      ),
      AppSnackbarType.error => (
        Icons.error,
        colorScheme.error,
        colorScheme.onError,
      ),
      AppSnackbarType.info => (
        Icons.info,
        colorScheme.primary,
        colorScheme.onPrimary,
      ),
    };

    ScaffoldMessenger.of(context)
      // 連打しても溜まらないよう、表示中のものは消してから出す。
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          content: Row(
            children: [
              Icon(icon, color: onColor),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(message, style: TextStyle(color: onColor)),
              ),
            ],
          ),
        ),
      );
  }
}
