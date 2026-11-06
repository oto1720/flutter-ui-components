import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// 「見出し＋中身」をひとまとめにする共通レイアウト。
///
/// カタログ画面やサンプル画面で「セクション」を何度も作るとき、
/// 見出しと余白の付け方を毎回書くのは手間だし、ばらつく。
/// レイアウトもコンポーネント化すると統一できる、という例。
class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.md),
          ...children,
        ],
      ),
    );
  }
}
