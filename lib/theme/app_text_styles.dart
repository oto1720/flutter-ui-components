import 'package:flutter/material.dart';

/// テキストスタイルの共通定義（ミニマル・モノクロ版）。
///
/// 色数が少ない分、「文字の大きさと太さの差」で情報の強弱を付ける。
/// 見出しは大きく・極太・字間を少し詰める。本文は細く・行間を広めに。
/// この差（ジャンプ率）が大きいほど、メリハリのある画面になる。
///
/// ここでは「大きさ」と「太さ」だけを決め、色は持たせない。
/// 文字色は Theme（ColorScheme）から自動で付くものに任せる。
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 1.2,
  );

  static const TextStyle title = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// 補足テキスト。色を弱めたいときは使う側で
  /// `colorScheme.onSurfaceVariant` を合わせる。
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle label = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
}
