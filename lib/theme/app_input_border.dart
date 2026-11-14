import 'package:flutter/material.dart';

/// 「塗りだけ」の入力欄のための枠（ミニマル・モノクロ版で追加）。
///
/// 標準の [OutlineInputBorder] は、ラベルが浮き上がると「枠線の上」に乗る。
/// 枠線が見えている前提の配置なので、線を消して塗りだけにすると、
/// ラベルが入力欄の外にはみ出したように見えてしまう。
///
/// そこで [isOutline] を false にして、ラベルが「入力欄の内側の上部」に
/// 収まるようにしている。形（四隅の角丸）とフォーカス時の線は
/// OutlineInputBorder のものをそのまま使う。
class AppFilledInputBorder extends OutlineInputBorder {
  const AppFilledInputBorder({
    super.borderSide = BorderSide.none,
    super.borderRadius,
  });

  /// false にすると、浮き上がったラベルが枠の内側に配置される。
  @override
  bool get isOutline => false;

  /// ラベルは枠線の上に乗らないので、線に「ラベル用の切れ目」を作らない。
  /// （gapStart などを渡さずに描くと、切れ目のない一周の線になる。）
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    super.paint(canvas, rect, textDirection: textDirection);
  }

  // 以下は、色や太さを変えたコピーを作るときも同じ型を保つためのもの。
  // （InputDecorator は状態が変わるたびに copyWith / lerp で枠を作り直す。）
  @override
  AppFilledInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
  }) {
    return AppFilledInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  AppFilledInputBorder scale(double t) {
    return AppFilledInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is OutlineInputBorder) {
      return AppFilledInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is OutlineInputBorder) {
      return AppFilledInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }
}
