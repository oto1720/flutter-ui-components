import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/components/inputs/app_search_field.dart';
import 'package:flutter_ui_components/theme/app_theme.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  testWidgets('入力するとクリアボタンが出て、押すと空になる', (tester) async {
    final changes = <String>[];
    var cleared = false;
    await tester.pumpWidget(
      wrap(
        AppSearchField(onChanged: changes.add, onClear: () => cleared = true),
      ),
    );
    expect(find.byIcon(Icons.clear), findsNothing);

    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pump();
    expect(find.byIcon(Icons.clear), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    expect(find.text('flutter'), findsNothing);
    expect(find.byIcon(Icons.clear), findsNothing);
    expect(cleared, isTrue);
    expect(changes, ['flutter', '']);
  });

  testWidgets('外から渡した controller の変更にも追従する', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(wrap(AppSearchField(controller: controller)));

    controller.text = 'dart';
    await tester.pump();
    expect(find.byIcon(Icons.clear), findsOneWidget);
  });
}
