import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 画面上に一瞬だけ出す軽い通知（トースト）。
///
/// 設計方針:
/// - SnackBar と違い Scaffold に依存せず、[Overlay] に直接差し込む。
///   「Overlay に Widget を乗せて、一定時間後に自分で消す」という仕組みの例。
/// - 表示位置は画面下寄り。色は Theme を基にする。
class AppToast {
  AppToast._();

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        child: IgnorePointer(
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.inverseSurface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: colorScheme.onInverseSurface),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    // 一定時間後に自分で取り除く。
    Future.delayed(duration, entry.remove);
  }
}
