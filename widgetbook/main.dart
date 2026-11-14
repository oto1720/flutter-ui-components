import 'package:flutter/material.dart';
import 'package:flutter_ui_components/components/advanced/app_animated_button.dart';
import 'package:flutter_ui_components/components/advanced/app_carousel.dart';
import 'package:flutter_ui_components/components/advanced/app_timeline.dart';
import 'package:flutter_ui_components/components/buttons/app_button.dart';
import 'package:flutter_ui_components/components/buttons/app_fab.dart';
import 'package:flutter_ui_components/components/buttons/app_icon_button.dart';
import 'package:flutter_ui_components/components/buttons/app_segmented_button.dart';
import 'package:flutter_ui_components/components/cards/app_card.dart';
import 'package:flutter_ui_components/components/chips/app_chip.dart';
import 'package:flutter_ui_components/components/display/app_avatar.dart';
import 'package:flutter_ui_components/components/display/app_badge.dart';
import 'package:flutter_ui_components/components/display/app_divider.dart';
import 'package:flutter_ui_components/components/display/app_list_tile.dart';
import 'package:flutter_ui_components/components/display/app_progress_bar.dart';
import 'package:flutter_ui_components/components/display/app_rating_stars.dart';
import 'package:flutter_ui_components/components/display/app_tag.dart';
import 'package:flutter_ui_components/components/feedback/app_empty_state.dart';
import 'package:flutter_ui_components/components/feedback/app_skeleton.dart';
import 'package:flutter_ui_components/components/inputs/app_checkbox.dart';
import 'package:flutter_ui_components/components/inputs/app_dropdown.dart';
import 'package:flutter_ui_components/components/inputs/app_radio_group.dart';
import 'package:flutter_ui_components/components/inputs/app_search_field.dart';
import 'package:flutter_ui_components/components/inputs/app_slider.dart';
import 'package:flutter_ui_components/components/inputs/app_switch.dart';
import 'package:flutter_ui_components/components/layout/app_accordion.dart';
import 'package:flutter_ui_components/components/layout/app_spacer.dart';
import 'package:flutter_ui_components/components/navigation/app_bottom_nav.dart';
import 'package:flutter_ui_components/components/text_fields/app_text_field.dart';
import 'package:flutter_ui_components/theme/app_spacing.dart';
import 'package:flutter_ui_components/theme/app_theme.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook アプリのエントリポイント。
///
/// 起動: `flutter run -t widgetbook/main.dart -d chrome`（または macOS/モバイル）
///
/// 本体アプリ（lib/main.dart）とは別のエントリにすることで、
/// 「アプリに組み込まなくても部品単体で確認できる」状態を作る。
/// 各 UseCase が 1 つの状態（Primary / Disabled / Loading ...）に対応する。
/// コンポーネントが増えてきたので、カテゴリごとに [WidgetbookFolder] でまとめている。
void main() => runApp(const WidgetbookApp());

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: AppTheme.light),
            WidgetbookTheme(name: 'Dark', data: AppTheme.dark),
          ],
        ),
        TextScaleAddon(),
        AlignmentAddon(),
      ],
      directories: [
        _buttonsFolder(),
        _inputsFolder(),
        _displayFolder(),
        _feedbackFolder(),
        _layoutFolder(),
        _advancedFolder(),
      ],
    );
  }
}

// ----------------------------------------------------------------------------
// Buttons
// ----------------------------------------------------------------------------
WidgetbookFolder _buttonsFolder() {
  return WidgetbookFolder(
    name: 'Buttons',
    children: [
      WidgetbookComponent(
        name: 'AppButton',
        useCases: [
          // Knobs（右側のパネル）で引数を自由に切り替えて試せる UseCase。
          // 状態ごとに UseCase を手書きしなくても、全ての組み合わせを確認できる。
          WidgetbookUseCase(
            name: 'Playground',
            builder: (context) => AppButton(
              label: context.knobs.string(label: 'label', initialValue: 'ログイン'),
              variant: context.knobs.object.dropdown(
                label: 'variant',
                options: AppButtonVariant.values,
                labelBuilder: (v) => v.name,
              ),
              tone: context.knobs.object.dropdown(
                label: 'tone',
                options: AppButtonTone.values,
                labelBuilder: (v) => v.name,
              ),
              size: context.knobs.object.dropdown(
                label: 'size',
                options: AppButtonSize.values,
                initialOption: AppButtonSize.md,
                labelBuilder: (v) => v.name,
              ),
              leadingIcon: context.knobs.boolean(label: 'leadingIcon')
                  ? Icons.add
                  : null,
              trailingIcon: context.knobs.boolean(label: 'trailingIcon')
                  ? Icons.arrow_forward
                  : null,
              isLoading: context.knobs.boolean(label: 'isLoading'),
              isFullWidth: context.knobs.boolean(label: 'isFullWidth'),
              animatePress: context.knobs.boolean(label: 'animatePress'),
              onPressed: context.knobs.boolean(label: 'enabled', initialValue: true)
                  ? () {}
                  : null,
            ),
          ),
          // variant（強さ）× tone（意味）の全組み合わせを一覧する。
          WidgetbookUseCase(
            name: 'Variants × Tones',
            builder: (context) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final tone in AppButtonTone.values)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        alignment: WrapAlignment.center,
                        children: [
                          for (final variant in AppButtonVariant.values)
                            AppButton(
                              label: variant.name,
                              variant: variant,
                              tone: tone,
                              onPressed: () {},
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          WidgetbookUseCase(
            name: 'Sizes',
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final size in AppButtonSize.values) ...[
                  AppButton(
                    label: size.name,
                    size: size,
                    leadingIcon: Icons.add,
                    onPressed: () {},
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ],
            ),
          ),
          // 無効・ローディングを全 variant で並べる（幅が変わらないことも確認できる）。
          WidgetbookUseCase(
            name: 'States',
            builder: (context) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final variant in AppButtonVariant.values)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        alignment: WrapAlignment.center,
                        children: [
                          AppButton(
                            label: '送信する',
                            variant: variant,
                            onPressed: () {},
                          ),
                          AppButton(
                            label: '送信する',
                            variant: variant,
                            onPressed: null,
                          ),
                          AppButton(
                            label: '送信する',
                            variant: variant,
                            isLoading: true,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppIconButton',
        useCases: [
          WidgetbookUseCase(
            name: 'Ghost',
            builder: (context) =>
                AppIconButton(icon: Icons.favorite, onPressed: () {}),
          ),
          WidgetbookUseCase(
            name: 'Filled',
            builder: (context) => AppIconButton(
              icon: Icons.favorite,
              variant: AppIconButtonVariant.filled,
              onPressed: () {},
            ),
          ),
          WidgetbookUseCase(
            name: 'Outlined',
            builder: (context) => AppIconButton(
              icon: Icons.favorite,
              variant: AppIconButtonVariant.outlined,
              onPressed: () {},
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppFab',
        useCases: [
          WidgetbookUseCase(
            name: 'Regular',
            builder: (context) => AppFab(icon: Icons.add, onPressed: () {}),
          ),
          WidgetbookUseCase(
            name: 'Small',
            builder: (context) =>
                AppFab(icon: Icons.add, type: AppFabType.small, onPressed: () {}),
          ),
          WidgetbookUseCase(
            name: 'Extended',
            builder: (context) => AppFab(
              icon: Icons.add,
              type: AppFabType.extended,
              label: '新規作成',
              onPressed: () {},
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppSegmentedButton',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => AppSegmentedButton<int>(
              segments: const [
                AppSegment(value: 0, label: '日'),
                AppSegment(value: 1, label: '週'),
                AppSegment(value: 2, label: '月'),
              ],
              selected: 1,
              onChanged: (_) {},
            ),
          ),
        ],
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Inputs
// ----------------------------------------------------------------------------
WidgetbookFolder _inputsFolder() {
  return WidgetbookFolder(
    name: 'Inputs',
    children: [
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
        name: 'AppCheckbox',
        useCases: [
          WidgetbookUseCase(
            name: 'Checked',
            builder: (context) =>
                AppCheckbox(label: '利用規約に同意する', value: true, onChanged: (_) {}),
          ),
          WidgetbookUseCase(
            name: 'Unchecked',
            builder: (context) =>
                AppCheckbox(label: '利用規約に同意する', value: false, onChanged: (_) {}),
          ),
          WidgetbookUseCase(
            name: 'Disabled',
            builder: (context) =>
                const AppCheckbox(label: '選択できません', value: false, onChanged: null),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppRadioGroup',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => AppRadioGroup<String>(
              options: const [
                AppRadioOption(value: 'a', label: 'プランA'),
                AppRadioOption(value: 'b', label: 'プランB'),
                AppRadioOption(value: 'c', label: 'プランC'),
              ],
              groupValue: 'a',
              onChanged: (_) {},
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppSwitch',
        useCases: [
          WidgetbookUseCase(
            name: 'On',
            builder: (context) =>
                AppSwitch(label: '通知を受け取る', value: true, onChanged: (_) {}),
          ),
          WidgetbookUseCase(
            name: 'Off',
            builder: (context) =>
                AppSwitch(label: '通知を受け取る', value: false, onChanged: (_) {}),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppSlider',
        useCases: [
          WidgetbookUseCase(
            name: 'Continuous',
            builder: (context) =>
                AppSlider(label: '音量', value: 0.5, onChanged: (_) {}),
          ),
          WidgetbookUseCase(
            name: 'Steps',
            builder: (context) => AppSlider(
              label: '評価',
              value: 3,
              min: 0,
              max: 5,
              divisions: 5,
              onChanged: (_) {},
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppDropdown',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => AppDropdown<String>(
              label: '都道府県',
              items: const [
                AppDropdownItem(value: 'fukuoka', label: '福岡県'),
                AppDropdownItem(value: 'tokyo', label: '東京都'),
                AppDropdownItem(value: 'osaka', label: '大阪府'),
              ],
              value: 'fukuoka',
              onChanged: (_) {},
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppSearchField',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => const AppSearchField(),
          ),
        ],
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Display
// ----------------------------------------------------------------------------
WidgetbookFolder _displayFolder() {
  return WidgetbookFolder(
    name: 'Display',
    children: [
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
            builder: (context) => const AppChip(label: 'Flutter', selected: true),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppBadge',
        useCases: [
          WidgetbookUseCase(
            name: 'Number',
            builder: (context) => const AppBadge(
              count: 3,
              child: Icon(Icons.notifications, size: 32),
            ),
          ),
          WidgetbookUseCase(
            name: 'Dot',
            builder: (context) => const AppBadge(
              type: AppBadgeType.dot,
              child: Icon(Icons.mail, size: 32),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppAvatar',
        useCases: [
          WidgetbookUseCase(
            name: 'Initials',
            builder: (context) => const AppAvatar(initials: 'KT'),
          ),
          WidgetbookUseCase(
            name: 'Icon',
            builder: (context) => const AppAvatar(),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppTag',
        useCases: [
          WidgetbookUseCase(
            name: 'All statuses',
            builder: (context) => const Wrap(
              spacing: AppSpacing.sm,
              children: [
                AppTag(label: '成功', status: AppTagStatus.success),
                AppTag(label: '警告', status: AppTagStatus.warning),
                AppTag(label: 'エラー', status: AppTagStatus.error),
                AppTag(label: '情報', status: AppTagStatus.info),
              ],
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppDivider',
        useCases: [
          WidgetbookUseCase(
            name: 'Horizontal',
            builder: (context) => const AppDivider(),
          ),
          WidgetbookUseCase(
            name: 'Inset',
            builder: (context) => const AppDivider(inset: true),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppListTile',
        useCases: [
          WidgetbookUseCase(
            name: 'Full',
            builder: (context) => const AppListTile(
              title: '設定',
              subtitle: 'アプリの各種設定',
              leadingIcon: Icons.settings,
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppProgressBar',
        useCases: [
          WidgetbookUseCase(
            name: 'Linear 40%',
            builder: (context) => const AppProgressBar(value: 0.4),
          ),
          WidgetbookUseCase(
            name: 'Circular',
            builder: (context) =>
                const AppProgressBar(type: AppProgressType.circular),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppRatingStars',
        useCases: [
          WidgetbookUseCase(
            name: 'Display',
            builder: (context) => const AppRatingStars(rating: 3),
          ),
          WidgetbookUseCase(
            name: 'Interactive',
            builder: (context) =>
                AppRatingStars(rating: 3, onRatingChanged: (_) {}),
          ),
        ],
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Feedback
// ----------------------------------------------------------------------------
WidgetbookFolder _feedbackFolder() {
  return WidgetbookFolder(
    name: 'Feedback',
    children: [
      WidgetbookComponent(
        name: 'AppSkeleton',
        useCases: [
          WidgetbookUseCase(
            name: 'Lines',
            builder: (context) => const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSkeleton(width: 200),
                SizedBox(height: AppSpacing.sm),
                AppSkeleton(width: 150),
                SizedBox(height: AppSpacing.sm),
                AppSkeleton(width: 120),
              ],
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppEmptyState',
        useCases: [
          WidgetbookUseCase(
            name: 'No data',
            builder: (context) => const AppEmptyState(),
          ),
          WidgetbookUseCase(
            name: 'Error',
            builder: (context) =>
                AppEmptyState(type: AppEmptyStateType.error, onRetry: () {}),
          ),
          WidgetbookUseCase(
            name: 'Loading',
            builder: (context) =>
                const AppEmptyState(type: AppEmptyStateType.loading),
          ),
        ],
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Layout / Navigation
// ----------------------------------------------------------------------------
WidgetbookFolder _layoutFolder() {
  return WidgetbookFolder(
    name: 'Layout & Navigation',
    children: [
      WidgetbookComponent(
        name: 'AppAccordion',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => const AppAccordion(
              title: 'よくある質問',
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Text('ここに回答が入ります。'),
              ),
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppSpacer',
        useCases: [
          WidgetbookUseCase(
            name: 'Between two boxes',
            builder: (context) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 40, height: 40, color: Colors.blue),
                const AppSpacer(AppGap.lg),
                Container(width: 40, height: 40, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppBottomNav',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => AppBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                AppBottomNavItem(label: 'ホーム', icon: Icons.home),
                AppBottomNavItem(label: '検索', icon: Icons.search),
                AppBottomNavItem(label: 'マイページ', icon: Icons.person),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Advanced
// ----------------------------------------------------------------------------
WidgetbookFolder _advancedFolder() {
  return WidgetbookFolder(
    name: 'Advanced',
    children: [
      WidgetbookComponent(
        name: 'AppAnimatedButton',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) =>
                AppAnimatedButton(label: 'Press me', onPressed: () {}),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppCarousel',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => const AppCarousel(
              imageUrls: [
                'https://picsum.photos/seed/1/400/200',
                'https://picsum.photos/seed/2/400/200',
                'https://picsum.photos/seed/3/400/200',
              ],
            ),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'AppTimeline',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => const AppTimeline(
              entries: [
                AppTimelineEntry(title: '注文を受け付けました', subtitle: '10:00'),
                AppTimelineEntry(title: '発送しました', subtitle: '14:30'),
                AppTimelineEntry(title: 'お届け完了', subtitle: '翌日 12:00'),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
