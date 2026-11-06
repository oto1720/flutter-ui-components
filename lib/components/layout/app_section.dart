import 'package:flutter/material.dart';

// NOTE: 完成版のコードは `main` ブランチにあります。詰まったら参照してください。

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
    // TODO(handson): Column で「見出し(title) + children」を縦に並べる。
    //  - 見出しは AppTextStyles.heading
    //  - 見出しと中身の間、セクションの上下に AppSpacing で余白を入れる
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), ...children],
    );
  }
}
