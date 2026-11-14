import 'package:flutter/material.dart';

import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';

/// タグの意味（セマンティックカラー）。
///
/// 「赤・緑」と色で指定するのではなく、「success・error」と
/// 意味で指定するのがポイント。実際の色は Theme 側で決める。
enum AppTagStatus { success, warning, error, info }

/// 状態を色で表す小さなラベル（ステータスタグ）。
///
/// 設計方針:
/// - [status] に応じて配色を切り替える。色は ColorScheme と
///   AppSemanticColors（success / warning）から取り、
///   直接のカラーコードはここに書かない。
/// - 角丸・余白は AppSpacing を使う。
class AppTag extends StatelessWidget {
  const AppTag({super.key, required this.label, this.status = AppTagStatus.info});

  final String label;
  final AppTagStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (fg, bg) = _colorsFor(
      status,
      colorScheme,
      AppSemanticColors.of(context),
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// (文字色, 背景色) を status から決める。
  (Color, Color) _colorsFor(
    AppTagStatus status,
    ColorScheme scheme,
    AppSemanticColors semantic,
  ) {
    switch (status) {
      case AppTagStatus.success:
        return (semantic.onSuccessContainer, semantic.successContainer);
      case AppTagStatus.warning:
        return (semantic.onWarningContainer, semantic.warningContainer);
      case AppTagStatus.error:
        return (scheme.onErrorContainer, scheme.errorContainer);
      case AppTagStatus.info:
        return (scheme.onPrimaryContainer, scheme.primaryContainer);
    }
  }
}
