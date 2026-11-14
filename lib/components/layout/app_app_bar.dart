import 'package:flutter/material.dart';

/// アプリ共通の AppBar。
///
/// 設計方針:
/// - Scaffold の `appBar:` に渡すため [PreferredSizeWidget] を実装する。
///   （高さを Scaffold に伝える必要があるので、ただの Widget ではダメ。）
/// - [actions] は右側のアクションボタン群、[onBack] を渡すと戻るボタンを出す。
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: false,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
            )
          : null,
      actions: actions,
    );
  }

  // AppBar の標準の高さを返す。
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
