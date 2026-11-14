import 'package:flutter/material.dart';

// NOTE: 完成版のコードは `main` ブランチにあります。詰まったら参照してください。

/// タイトル・説明・画像（任意）を表示する共通カード。
///
/// 設計方針:
/// - [title] は必須。[description] と [imageUrl] は任意。
///   「ある項目は出す／ない項目は出さない」を build の中で分岐する。
/// - 余白は AppSpacing を参照する。角丸は Theme の `cardTheme` で決めている。
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
    // TODO(handson): Card を実装する。
    //  - title は常に表示、description / imageUrl は null でないときだけ表示する
    //    （`if (description != null) ...` で分岐）
    //  - onTap を渡せるよう InkWell で包む
    //  - 余白は AppSpacing、文字は AppTextStyles を使う
    //    （角丸は Theme の cardTheme で決めてあるので指定しなくてよい）
    return const Placeholder(fallbackHeight: 120);
  }
}
