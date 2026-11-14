import 'package:flutter/material.dart';

/// テキストスタイルの共通定義。
///
/// 見出し・本文・ラベルといった「役割」でスタイルを決めておくと、
/// フォントサイズをコードに直接書かずに済み、統一感が出る。
///
/// ここでは「大きさ」と「太さ」だけを決め、色は持たせない。
/// 色を直書きすると Dark テーマで背景と同化して読めなくなるため、
/// 文字色は Theme（ColorScheme）から自動で付くものに任せる。
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// 補足テキスト。色を弱めたいときは使う側で
  /// `colorScheme.onSurfaceVariant` を合わせる。
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
