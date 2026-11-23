import 'package:flutter/material.dart';

import '../../previews/app_preview.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

/// タイトル・説明・画像（任意）を表示する共通カード。
///
/// 設計方針:
/// - [title] は必須。[description] と [imageUrl] は任意。
///   「ある項目は出す／ない項目は出さない」を build の中で分岐する。
/// - 余白は AppSpacing を参照する。角丸は Theme の `cardTheme` で決めている。
/// - [onTap] を渡すとカード全体をタップできる。
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.title,
    this.description,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String? description;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 画像は指定されたときだけ表示する。
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                // 画像の読み込みに失敗しても画面が壊れないようにする。
                errorBuilder: (_, _, _) => Container(
                  height: 140,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: AppTextStyles.title),
                  if (description != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(description!, style: AppTextStyles.body),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// Widget Previews（`flutter widget-preview start` で確認）
// ----------------------------------------------------------------------------
// 画像あり（Image.network）は Previewer の Web 環境で読み込み制限を受けることが
// あるので、ここではテキストのみの状態を確認する。

@AppPreview(group: 'AppCard', name: 'Title only')
Widget appCardTitleOnlyPreview() => const AppCard(title: 'カードのタイトル');

@AppPreview(group: 'AppCard', name: 'With description')
Widget appCardWithDescriptionPreview() => AppCard(
  title: 'Flutter UI Components Lab',
  description: '再利用可能な UI コンポーネントを設計して、カタログ化する勉強会です。',
  onTap: () {},
);
