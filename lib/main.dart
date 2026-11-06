import 'package:flutter/material.dart';

import 'components/buttons/app_button.dart';
import 'components/cards/app_card.dart';
import 'components/chips/app_chip.dart';
import 'components/layout/app_section.dart';
import 'components/text_fields/app_text_field.dart';
import 'theme/app_spacing.dart';
import 'theme/app_theme.dart';

void main() => runApp(const DemoApp());

/// 作ったコンポーネントを実際に並べたサンプルアプリ。
///
/// 「使う」フェーズの成果物。ここに並べたのと同じ部品を、
/// Widgetbook では 1 つずつ切り離して確認できる（widgetbook/main.dart）。
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Components Lab',
      theme: AppTheme.light, // ← ここで全体にテーマが効く
      debugShowCheckedModeBanner: false,
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  bool _loading = false;
  bool _chipSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Components Catalog')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSection(
              title: 'Buttons',
              children: [
                AppButton(label: 'Primary', onPressed: () {}),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Secondary',
                  type: AppButtonType.secondary,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Outlined',
                  type: AppButtonType.outlined,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                const AppButton(label: 'Disabled', onPressed: null),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Tap to load',
                  isLoading: _loading,
                  onPressed: () async {
                    setState(() => _loading = true);
                    await Future<void>.delayed(const Duration(seconds: 1));
                    if (mounted) setState(() => _loading = false);
                  },
                ),
              ],
            ),
            const AppSection(
              title: 'Text Fields',
              children: [
                AppTextField(label: 'お名前', hintText: '福大 太郎'),
                SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'メールアドレス',
                  errorText: 'メールアドレスの形式が正しくありません',
                ),
                SizedBox(height: AppSpacing.md),
                AppTextField(label: 'パスワード', obscureText: true),
              ],
            ),
            const AppSection(
              title: 'Cards',
              children: [
                AppCard(
                  title: 'UI Components Lab',
                  description: '再利用可能なコンポーネントを設計し、Widgetbook でカタログ化しよう。',
                ),
              ],
            ),
            AppSection(
              title: 'Chips',
              children: [
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    AppChip(
                      label: _chipSelected ? '選択中' : 'タップで選択',
                      selected: _chipSelected,
                      onSelected: (v) => setState(() => _chipSelected = v),
                    ),
                    const AppChip(label: 'Flutter'),
                    const AppChip(label: 'Dart'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
