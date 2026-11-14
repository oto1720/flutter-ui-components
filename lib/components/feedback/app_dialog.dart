import 'package:flutter/material.dart';

/// 確認・通知用の共通ダイアログ。
///
/// 設計方針:
/// - Widget ではなく「呼び出すヘルパー」。戻り値で結果を受け取れる。
/// - [AppDialog.confirm] は OK/キャンセルの確認用で `Future<bool>` を返す。
///   「はい」なら true、閉じた/キャンセルなら false。
/// - [AppDialog.alert] は通知用で、閉じたら完了。
class AppDialog {
  AppDialog._();

  /// OK / キャンセルの確認ダイアログ。押した結果を bool で返す。
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    String cancelLabel = 'キャンセル',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    // ダイアログ外タップで閉じた場合は null → false 扱い。
    return result ?? false;
  }

  /// OK だけの通知ダイアログ。
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
