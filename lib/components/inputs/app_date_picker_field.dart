import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// 日付を選ぶ入力フィールド。
///
/// 設計方針:
/// - 見た目は入力欄だが、タップすると標準の [showDatePicker] を開く。
/// - 状態（選択された日付）は親が持ち、[onChanged] で通知する。
/// - 日付の表示整形はあえてシンプルに `YYYY/MM/DD`。
///   （本格的には intl パッケージでロケール対応するのが発展課題。）
class AppDatePickerField extends StatelessWidget {
  const AppDatePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: firstDate ?? DateTime(now.year - 5),
          lastDate: lastDate ?? DateTime(now.year + 5),
        );
        if (picked != null) onChanged(picked);
      },
      // enabled: false で入力は無効化しつつ、見た目だけ入力欄として使う。
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(value != null ? _format(value!) : '日付を選択'),
      ),
    );
  }

  String _format(DateTime d) =>
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
}
