import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/components/buttons/app_button.dart';
import 'package:flutter_ui_components/theme/app_semantic_colors.dart';
import 'package:flutter_ui_components/theme/app_theme.dart';

/// コンポーネントの widget test の例。
///
/// 「タップできる」「無効のときは押せない」といった振る舞いを自動で確認する。
/// 発展として、この見た目を画像で保証する Golden Test に発展できる（README 参照）。
void main() {
  /// テスト対象を AppTheme 付きの最小アプリで包む。
  Widget wrap(Widget child, {ThemeData? theme}) => MaterialApp(
    theme: theme ?? AppTheme.light,
    home: Scaffold(body: Center(child: child)),
  );

  /// ボタンの「見た目の箱」（タップ領域の余白を除いた部分）の大きさ。
  Size visualSize(WidgetTester tester) => tester.getSize(
    find.descendant(
      of: find.byType(AppButton),
      matching: find.byType(Material),
    ),
  );

  Material material(WidgetTester tester) => tester.widget<Material>(
    find.descendant(
      of: find.byType(AppButton),
      matching: find.byType(Material),
    ),
  );

  testWidgets('onPressed が呼ばれる', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(AppButton(label: 'Tap', onPressed: () => tapped = true)),
    );

    await tester.tap(find.text('Tap'));
    expect(tapped, isTrue);
  });

  testWidgets('onPressed が null なら無効になる', (tester) async {
    await tester.pumpWidget(
      wrap(const AppButton(label: 'Disabled', onPressed: null)),
    );

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('variant ごとに対応する標準ボタンが使われる', (tester) async {
    final expected = <AppButtonVariant, Type>{
      AppButtonVariant.filled: FilledButton,
      AppButtonVariant.tonal: FilledButton,
      AppButtonVariant.elevated: ElevatedButton,
      AppButtonVariant.outlined: OutlinedButton,
      AppButtonVariant.text: TextButton,
    };
    for (final entry in expected.entries) {
      await tester.pumpWidget(
        wrap(AppButton(label: 'x', variant: entry.key, onPressed: () {})),
      );
      expect(find.byType(entry.value), findsOneWidget, reason: '${entry.key}');
    }
  });

  testWidgets('size ごとに高さが変わる（sm < md < lg）', (tester) async {
    for (final size in AppButtonSize.values) {
      await tester.pumpWidget(
        wrap(AppButton(label: 'Size', size: size, onPressed: () {})),
      );
      await tester.pumpAndSettle();
      expect(visualSize(tester).height, size.height, reason: '$size');
    }
  });

  testWidgets('ラベルの太さが Theme の labelLarge から引き継がれる', (tester) async {
    await tester.pumpWidget(wrap(AppButton(label: 'Bold', onPressed: () {})));

    final text = tester.widget<RichText>(
      find.descendant(
        of: find.byType(AppButton),
        matching: find.byType(RichText),
      ),
    );
    expect(text.text.style?.fontWeight, FontWeight.w600);
  });

  testWidgets('tone: danger は Theme の error 色になる', (tester) async {
    await tester.pumpWidget(
      wrap(AppButton(label: '削除', tone: AppButtonTone.danger, onPressed: () {})),
    );
    expect(material(tester).color, AppTheme.light.colorScheme.error);

    // variant と独立した軸なので、枠線だけの danger も作れる。
    await tester.pumpWidget(
      wrap(
        AppButton(
          label: '削除',
          variant: AppButtonVariant.outlined,
          tone: AppButtonTone.danger,
          onPressed: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();
    final shape = material(tester).shape! as RoundedRectangleBorder;
    expect(shape.side.color, AppTheme.light.colorScheme.error);
  });

  testWidgets('tone: success は Light / Dark それぞれの成功色になる', (tester) async {
    for (final (theme, colors) in [
      (AppTheme.light, AppSemanticColors.light),
      (AppTheme.dark, AppSemanticColors.dark),
    ]) {
      await tester.pumpWidget(
        wrap(
          AppButton(label: '完了', tone: AppButtonTone.success, onPressed: () {}),
          theme: theme,
        ),
      );
      await tester.pumpAndSettle();
      expect(material(tester).color, colors.success);
    }
  });

  testWidgets('isLoading 中はスピナーを表示し、押せない', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(
        AppButton(
          label: 'Load',
          isLoading: true,
          onPressed: () => tapped = true,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(AppButton), warnIfMissed: false);
    expect(tapped, isFalse);
  });

  testWidgets('isLoading でもボタンの大きさが変わらない', (tester) async {
    await tester.pumpWidget(
      wrap(AppButton(label: 'ログインする', leadingIcon: Icons.login, onPressed: () {})),
    );
    final normal = visualSize(tester);

    await tester.pumpWidget(
      wrap(
        AppButton(
          label: 'ログインする',
          leadingIcon: Icons.login,
          isLoading: true,
          onPressed: () {},
        ),
      ),
    );
    expect(visualSize(tester), normal);
  });

  testWidgets('isFullWidth で親の幅いっぱいに広がる', (tester) async {
    await tester.pumpWidget(
      wrap(AppButton(label: 'Wide', isFullWidth: true, onPressed: () {})),
    );
    expect(visualSize(tester).width, 800); // テスト画面の既定幅
  });

  testWidgets('animatePress は押している間だけ縮む', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(
        AppButton(
          label: 'Press',
          animatePress: true,
          onPressed: () => tapped = true,
        ),
      ),
    );
    AnimatedScale scale() =>
        tester.widget<AnimatedScale>(find.byType(AnimatedScale));

    expect(scale().scale, 1.0);
    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(AppButton)),
    );
    await tester.pump();
    expect(scale().scale, lessThan(1.0));

    await gesture.up();
    await tester.pumpAndSettle();
    expect(scale().scale, 1.0);
    expect(tapped, isTrue);
  });
}
