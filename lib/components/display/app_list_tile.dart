import 'package:flutter/material.dart';

/// タイトル・サブタイトル・前後の要素をまとめた共通リスト行。
///
/// 設計方針:
/// - [title] は必須。[subtitle] / [leadingIcon] / [trailing] は任意。
///   「ある項目は出す／ない項目は出さない」を組み合わせて 1 行を作る。
/// - [onTap] を渡すと行全体をタップできる。
class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon != null ? Icon(leadingIcon) : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
