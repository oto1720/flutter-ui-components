import 'package:flutter/material.dart';

/// ユーザーのアイコンを表す共通アバター。
///
/// 設計方針:
/// - 表示の優先順位を「画像 → イニシャル → アイコン」と決めておき、
///   指定された情報に応じて自動で fallback する（画像が無くても壊れない）。
/// - [size] で直径を指定できる。色は Theme から取る。
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon = Icons.person,
    this.size = 40,
  });

  final String? imageUrl;
  final String? initials;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = size / 2;

    // 1) 画像があれば画像を最優先。
    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        // 画像読み込み失敗時に備え、背景色も設定しておく。
        backgroundColor: colorScheme.surfaceContainerHighest,
      );
    }

    // 2) 画像が無くイニシャルがあれば、頭文字を表示。
    if (initials != null && initials!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: colorScheme.primaryContainer,
        child: Text(
          initials!,
          style: TextStyle(
            fontSize: size * 0.4,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      );
    }

    // 3) どちらも無ければアイコンにフォールバック。
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.surfaceContainerHighest,
      child: Icon(icon, size: size * 0.6, color: colorScheme.onSurfaceVariant),
    );
  }
}
