import 'package:flutter/material.dart';

/// ボトムナビの項目 1 つ分。
class AppBottomNavItem {
  const AppBottomNavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

/// 画面下部のナビゲーションバー（2〜5 タブ）。
///
/// 設計方針:
/// - 選択中のインデックス（[currentIndex]）は親が持ち、[onTap] で通知する。
///   「見た目は子・状態は親」の形。どのページを表示するかは親が決める。
/// - Material 3 の [NavigationBar] を使う。
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  }) : assert(items.length >= 2 && items.length <= 5, 'タブは 2〜5 個にしてください');

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        for (final item in items)
          NavigationDestination(icon: Icon(item.icon), label: item.label),
      ],
    );
  }
}
