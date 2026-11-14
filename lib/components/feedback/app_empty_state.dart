import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 中身が無い／エラー／読み込み中の画面状態。
enum AppEmptyStateType { noData, error, loading }

/// 「データが無い」などの空状態をまとめて表示する共通 Widget。
///
/// 設計方針:
/// - リスト画面などで「データ 0 件」「読み込み失敗」「読み込み中」を
///   毎回バラバラに作らず、1 つの Widget で出し分ける。
/// - [type] に応じてアイコン・既定メッセージを変える。
/// - [onRetry] を渡すと再試行ボタンを表示する（error でよく使う）。
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.type = AppEmptyStateType.noData,
    this.message,
    this.onRetry,
  });

  final AppEmptyStateType type;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // loading だけは中央のスピナーにする。
    if (type == AppEmptyStateType.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final (icon, defaultMessage) = switch (type) {
      AppEmptyStateType.noData => (Icons.inbox_outlined, 'データがありません'),
      AppEmptyStateType.error => (Icons.error_outline, '読み込みに失敗しました'),
      AppEmptyStateType.loading => (Icons.hourglass_empty, ''),
    };
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: colorScheme.onSurfaceVariant),
          const SizedBox(height: AppSpacing.md),
          Text(
            message ?? defaultMessage,
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(onPressed: onRetry, child: const Text('再試行')),
          ],
        ],
      ),
    );
  }
}
