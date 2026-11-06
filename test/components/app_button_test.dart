import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/components/buttons/app_button.dart';

/// コンポーネントの widget test の例。
///
/// 「タップできる」「無効のときは押せない」といった振る舞いを自動で確認する。
/// 発展として、この見た目を画像で保証する Golden Test に発展できる（README 参照）。
void main() {
  testWidgets('onPressed が呼ばれる', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(label: 'Tap', onPressed: () => tapped = true),
        ),
      ),
    );

    await tester.tap(find.text('Tap'));
    expect(tapped, isTrue);
  });

  testWidgets('onPressed が null なら無効になる', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppButton(label: 'Disabled', onPressed: null),
        ),
      ),
    );

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('isLoading 中はスピナーを表示する', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(label: 'Load', isLoading: true, onPressed: () {}),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Load'), findsNothing);
  });
}
