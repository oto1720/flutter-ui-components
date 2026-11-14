import 'package:flutter/material.dart';

/// タップで開閉する共通アコーディオン。
///
/// 設計方針:
/// - [title] が見出し、[child] が開いたときに出る中身。
/// - 開閉アニメーションは標準の [ExpansionTile] に任せる
///   （自前で高さを animate しなくてよい）。
/// - [initiallyExpanded] で最初から開いた状態にもできる。
class AppAccordion extends StatelessWidget {
  const AppAccordion({
    super.key,
    required this.title,
    required this.child,
    this.leadingIcon,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget child;
  final IconData? leadingIcon;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      leading: leadingIcon != null ? Icon(leadingIcon) : null,
      initiallyExpanded: initiallyExpanded,
      children: [child],
    );
  }
}
