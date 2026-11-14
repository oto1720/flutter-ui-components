import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 画面下から出てくる共通ボトムシート。
///
/// 設計方針:
/// - Widget ではなく「呼び出すヘルパー」。中身（[child]）は呼び出し側が渡す。
/// - [scrollable] を true にすると、内容が長いときにスクロールできる形で開く。
/// - 上部に「つまみ（ハンドル）」を出して、下に引いて閉じられることを示す。
class AppBottomSheet {
  AppBottomSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool scrollable = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      // scrollable なら高さを内容に合わせて伸ばせるようにする。
      isScrollControlled: scrollable,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: scrollable
            ? SingleChildScrollView(child: child)
            : SafeArea(child: child),
      ),
    );
  }
}
