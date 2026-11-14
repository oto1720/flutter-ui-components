import 'package:flutter/material.dart';

import 'components/buttons/app_button.dart';
import 'components/buttons/app_icon_button.dart';
import 'components/cards/app_card.dart';
import 'components/chips/app_chip.dart';
import 'components/display/app_avatar.dart';
import 'components/display/app_rating_stars.dart';
import 'components/display/app_tag.dart';
import 'components/feedback/app_dialog.dart';
import 'components/feedback/app_snackbar.dart';
import 'components/inputs/app_checkbox.dart';
import 'components/inputs/app_switch.dart';
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
      darkTheme: AppTheme.dark, // 端末がダークモードならこちらが使われる
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
  bool _agree = false;
  bool _notify = true;
  int _rating = 3;

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
                  variant: AppButtonVariant.tonal,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Outlined',
                  variant: AppButtonVariant.outlined,
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
            AppSection(
              title: 'Inputs',
              children: [
                AppCheckbox(
                  label: '利用規約に同意する',
                  value: _agree,
                  onChanged: (v) => setState(() => _agree = v),
                ),
                AppSwitch(
                  label: '通知を受け取る',
                  value: _notify,
                  onChanged: (v) => setState(() => _notify = v),
                ),
              ],
            ),
            AppSection(
              title: 'Display',
              children: [
                Row(
                  children: [
                    const AppAvatar(initials: 'KT'),
                    const SizedBox(width: AppSpacing.md),
                    const AppTag(label: '成功', status: AppTagStatus.success),
                    const SizedBox(width: AppSpacing.sm),
                    const AppTag(label: 'エラー', status: AppTagStatus.error),
                    const Spacer(),
                    AppIconButton(
                      icon: Icons.favorite,
                      variant: AppIconButtonVariant.outlined,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                AppRatingStars(
                  rating: _rating,
                  onRatingChanged: (v) => setState(() => _rating = v),
                ),
              ],
            ),
            AppSection(
              title: 'Feedback',
              children: [
                AppButton(
                  label: 'スナックバーを表示',
                  variant: AppButtonVariant.tonal,
                  onPressed: () => AppSnackbar.show(
                    context,
                    '保存しました',
                    type: AppSnackbarType.success,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: '削除ダイアログ',
                  tone: AppButtonTone.danger,
                  onPressed: () async {
                    final ok = await AppDialog.confirm(
                      context,
                      title: '削除しますか？',
                      message: 'この操作は取り消せません。',
                      confirmLabel: '削除',
                      isDestructive: true,
                    );
                    if (ok && context.mounted) {
                      AppSnackbar.show(context, '削除しました',
                          type: AppSnackbarType.info);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
