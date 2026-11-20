import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Flutter Widget Previewer 用の共通設定。
///
/// 起動: `flutter widget-preview start`
///
/// Widgetbook（widgetbook/main.dart）が「チームで見るカタログ」なのに対して、
/// Widget Previewer は「コンポーネントを書きながら手元で確認する」ための道具。
/// プレビューはコンポーネントと同じファイルに `@AppPreview(...)` で書く。
///
/// 注意: アノテーションに渡す値は const、コールバック（wrapper など）は
/// public な top-level 関数か static メソッドでなければならない。

/// ライトテーマを当てて余白を付ける。
Widget lightThemeWrapper(Widget child) => _wrap(AppTheme.light, child);

/// ダークテーマを当てて余白を付ける。
Widget darkThemeWrapper(Widget child) => _wrap(AppTheme.dark, child);

Widget _wrap(ThemeData theme, Widget child) {
  return Theme(
    data: theme,
    child: Builder(
      builder: (context) => ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: child,
        ),
      ),
    ),
  );
}

/// 1 つのプレビュー関数から Light / Dark の 2 枚を作るアノテーション。
///
/// ```dart
/// @AppPreview(group: 'AppButton', name: 'Primary')
/// Widget appButtonPrimaryPreview() => AppButton(label: '送信', onPressed: () {});
/// ```
final class AppPreview extends MultiPreview {
  const AppPreview({required this.group, required this.name});

  final String group;
  final String name;

  @override
  List<Preview> get previews => [
    Preview(
      group: group,
      name: '$name (Light)',
      brightness: Brightness.light,
      wrapper: lightThemeWrapper,
    ),
    Preview(
      group: group,
      name: '$name (Dark)',
      brightness: Brightness.dark,
      wrapper: darkThemeWrapper,
    ),
  ];
}
