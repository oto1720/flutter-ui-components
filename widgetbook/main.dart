import 'package:flutter/material.dart';
import 'package:flutter_ui_components/components/buttons/app_button.dart';
import 'package:flutter_ui_components/components/cards/app_card.dart';
import 'package:flutter_ui_components/components/chips/app_chip.dart';
import 'package:flutter_ui_components/components/text_fields/app_text_field.dart';
import 'package:flutter_ui_components/theme/app_theme.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook アプリのエントリポイント。
///
/// 起動: `flutter run -t widgetbook/main.dart -d chrome`（または macOS/モバイル）
///
/// 本体アプリ（lib/main.dart）とは別のエントリにすることで、
/// 「アプリに組み込まなくても部品単体で確認できる」状態を作る。
/// 各 UseCase が 1 つの状態（Primary / Disabled / Loading ...）に対応する。
void main() => runApp(const WidgetbookApp());

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // アドオン: 画面上部のツールバーから切り替えられる機能。
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: AppTheme.light),
          ],
        ),
        TextScaleAddon(),
        AlignmentAddon(),
      ],
      // コンポーネントごとに UseCase（状態違い）を並べる。
      directories: [
        WidgetbookComponent(
          name: 'AppButton',
          useCases: [
            WidgetbookUseCase(
              name: 'Primary',
              builder: (context) =>
                  AppButton(label: 'Primary', onPressed: () {}),
            ),
            WidgetbookUseCase(
              name: 'Secondary',
              builder: (context) => AppButton(
                label: 'Secondary',
                type: AppButtonType.secondary,
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Outlined',
              builder: (context) => AppButton(
                label: 'Outlined',
                type: AppButtonType.outlined,
                onPressed: () {},
              ),
            ),
            WidgetbookUseCase(
              name: 'Disabled',
              builder: (context) =>
                  const AppButton(label: 'Disabled', onPressed: null),
            ),
            WidgetbookUseCase(
              name: 'Loading',
              builder: (context) => AppButton(
                label: 'Loading',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'AppTextField',
          useCases: [
            WidgetbookUseCase(
              name: 'Normal',
              builder: (context) =>
                  const AppTextField(label: 'お名前', hintText: '福大 太郎'),
            ),
            WidgetbookUseCase(
              name: 'Error',
              builder: (context) => const AppTextField(
                label: 'メールアドレス',
                errorText: '形式が正しくありません',
              ),
            ),
            WidgetbookUseCase(
              name: 'Password',
              builder: (context) =>
                  const AppTextField(label: 'パスワード', obscureText: true),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'AppCard',
          useCases: [
            WidgetbookUseCase(
              name: 'Title + Description',
              builder: (context) => const AppCard(
                title: 'UI Components Lab',
                description: '再利用可能なコンポーネントを設計しよう。',
              ),
            ),
            WidgetbookUseCase(
              name: 'Title only',
              builder: (context) => const AppCard(title: 'タイトルのみ'),
            ),
          ],
        ),
        WidgetbookComponent(
          name: 'AppChip',
          useCases: [
            WidgetbookUseCase(
              name: 'Unselected',
              builder: (context) => const AppChip(label: 'Flutter'),
            ),
            WidgetbookUseCase(
              name: 'Selected',
              builder: (context) =>
                  const AppChip(label: 'Flutter', selected: true),
            ),
          ],
        ),
      ],
    );
  }
}
