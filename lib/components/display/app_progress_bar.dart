import 'package:flutter/material.dart';

/// 進捗表示の形。
enum AppProgressType { linear, circular }

/// 進捗を表す共通インジケータ。
///
/// 設計方針:
/// - [value] が null なら「進捗不明（くるくる回る）」、
///   0.0〜1.0 を渡すと「その割合まで進んだ」表示になる。
///   この「null か数値か」で determinate / indeterminate を切り替えるのは
///   Flutter 標準インジケータの慣習に合わせている。
/// - [type] で横棒／円形を切り替える。
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    this.type = AppProgressType.linear,
    this.value,
  });

  final AppProgressType type;
  final double? value;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppProgressType.linear:
        return LinearProgressIndicator(value: value);
      case AppProgressType.circular:
        return CircularProgressIndicator(value: value);
    }
  }
}
