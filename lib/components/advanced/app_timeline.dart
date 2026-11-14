import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// タイムラインの 1 件分。
class AppTimelineEntry {
  const AppTimelineEntry({required this.title, this.subtitle});

  final String title;
  final String? subtitle;
}

/// 縦に時系列を並べる共通タイムライン。
///
/// 設計方針:
/// - 各行の左に「丸＋縦線」を描き、履歴や進行状況を表現する。
///   最後の行だけ縦線を消す、という細かな分岐が描画の学びどころ。
/// - 色・余白は Theme / AppSpacing を使う。
class AppTimeline extends StatelessWidget {
  const AppTimeline({super.key, required this.entries});

  final List<AppTimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < entries.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 左側の「丸＋縦線」。
                Column(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary,
                      ),
                    ),
                    // 最後の行以外は縦線を伸ばす。
                    if (i != entries.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                // 右側のテキスト。
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entries[i].title, style: AppTextStyles.title),
                        if (entries[i].subtitle != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            entries[i].subtitle!,
                            style: AppTextStyles.caption.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
