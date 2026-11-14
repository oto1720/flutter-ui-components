import 'package:flutter/material.dart';

/// タブ 1 つ分（ラベルと中身のページ）。
class AppTab {
  const AppTab({required this.label, required this.content, this.icon});

  final String label;
  final Widget content;
  final IconData? icon;
}

/// タブで複数ページを切り替える共通コンポーネント。
///
/// 設計方針:
/// - [DefaultTabController] を内部に持つので、使う側は TabController を
///   自分で用意しなくてよい（よくある手間を隠す）。
/// - タブ定義とページ内容を [AppTab] のリストでまとめて渡す。
class AppTabBarView extends StatelessWidget {
  const AppTabBarView({super.key, required this.tabs});

  final List<AppTab> tabs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            tabs: [
              for (final tab in tabs)
                Tab(
                  text: tab.label,
                  icon: tab.icon != null ? Icon(tab.icon) : null,
                ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [for (final tab in tabs) tab.content],
            ),
          ),
        ],
      ),
    );
  }
}
