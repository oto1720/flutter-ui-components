import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/components/inputs/app_checkbox.dart';

void main() {
  testWidgets('タップで新しい値が通知される', (tester) async {
    bool? changedTo;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppCheckbox(
            label: '同意する',
            value: false,
            onChanged: (v) => changedTo = v,
          ),
        ),
      ),
    );

    await tester.tap(find.text('同意する'));
    expect(changedTo, isTrue);
  });

  testWidgets('onChanged が null なら無効になる', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppCheckbox(label: '選択不可', value: false, onChanged: null),
        ),
      ),
    );

    final checkbox = tester.widget<CheckboxListTile>(
      find.byType(CheckboxListTile),
    );
    expect(checkbox.onChanged, isNull);
  });
}
