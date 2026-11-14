import 'package:flutter/material.dart';

// NOTE: 完成版のコードは `main` ブランチにあります。詰まったら参照してください。
//       このファイルはハンズオンの開始地点（TODO 雛形）です。

/// ボタンの「見た目の強さ」。
///
/// 画面の中でどれだけ目立たせるかを決める。上から順に強い。
/// 1 画面に filled は 1 つ、残りは弱い見た目にすると主従がはっきりする。
enum AppButtonVariant {
  /// 塗りつぶし。画面で一番重要なアクション（FilledButton）。
  filled,

  /// 淡い塗り。次に重要なアクション（FilledButton.tonal）。
  tonal,

  /// 影付き。背景から浮かせたいとき（ElevatedButton）。
  elevated,

  /// 枠線のみ。補助アクション（OutlinedButton）。
  outlined,

  /// 背景なし・文字のみ。一番弱いアクション（TextButton）。
  text,
}

/// ボタンの「意味」。色を決める。
///
/// [AppButtonVariant] とは独立した軸なので、
/// 「枠線だけの削除ボタン」（outlined × danger）のように自由に組み合わせられる。
/// 1 つの enum に `danger` を混ぜてしまうと、この組み合わせが作れなくなる。
enum AppButtonTone {
  /// 通常のアクション（ブランドカラー）。
  primary,

  /// 削除・退会など破壊的なアクション（エラー色）。
  danger,

  /// 完了・承認など肯定的なアクション（成功色）。
  success,
}

/// ボタンの大きさ。高さ・余白・文字サイズ・アイコンサイズをまとめて切り替える。
///
/// enum に値を持たせておくと、`size.height` のように取り出せて
/// `switch` を何度も書かずに済む。
enum AppButtonSize {
  sm(height: 32, horizontalPadding: 12, fontSize: 13, iconSize: 16),
  md(height: 40, horizontalPadding: 16, fontSize: 14, iconSize: 18),
  lg(height: 48, horizontalPadding: 24, fontSize: 16, iconSize: 20);

  const AppButtonSize({
    required this.height,
    required this.horizontalPadding,
    required this.fontSize,
    required this.iconSize,
  });

  final double height;
  final double horizontalPadding;
  final double fontSize;
  final double iconSize;
}

/// アプリ共通のボタン。
///
/// 設計方針:
/// - [label] と [onPressed] は必須（required）。ボタンの本質なので省略させない。
/// - 見た目は [variant]（強さ）× [tone]（意味）× [size]（大きさ）の
///   3 つの enum の組み合わせで決まる。色違い・形違いを別 Widget にしない。
/// - [onPressed] に null を渡すと「無効（disabled）」状態になる。
/// - 色は Theme（ColorScheme / AppSemanticColors）から取り、ここに直書きしない。
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.tone = AppButtonTone.primary,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.isFullWidth = false,
    this.animatePress = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonTone tone;
  final AppButtonSize size;

  /// true の間はスピナーを表示し、押せなくする。
  final bool isLoading;

  /// 親の幅いっぱいに広げる（いわゆる block button）。
  final bool isFullWidth;

  /// 押している間だけ少し縮む「押した感触」を付ける（発展課題）。
  final bool animatePress;

  /// ラベルの前後に置くアイコン（任意）。
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    // TODO(handson): ボタンを実装する。
    //
    // ■ 基本（まずここまで）
    //  1. isLoading 中は onPressed を無効化し、CircularProgressIndicator を表示する
    //  2. variant に応じて標準ボタンを出し分ける（switch 式が便利）
    //       filled → FilledButton / tonal → FilledButton.tonal
    //       elevated → ElevatedButton / outlined → OutlinedButton / text → TextButton
    //  3. onPressed が null なら無効（標準ボタンにそのまま渡せば OK）
    //
    // ■ 拡張
    //  4. size: `XxxButton.styleFrom(minimumSize:, padding:, textStyle:)` に
    //     size.height / size.horizontalPadding / size.fontSize を渡す
    //     （textStyle は Theme の labelLarge を copyWith すると太さが保たれる）
    //  5. tone: danger なら colorScheme.error 系、success なら
    //     AppSemanticColors.of(context).success 系の色を styleFrom に渡す
    //     （primary は何も渡さず Theme の標準色に任せる）
    //  6. leadingIcon / trailingIcon があれば Row でラベルの前後に並べる
    //  7. isFullWidth なら SizedBox(width: double.infinity) で包む
    //
    // ■ 発展
    //  8. ローディング中もボタンの幅が変わらないようにする
    //     （ヒント: Stack + Visibility(maintainSize: true)）
    //  9. animatePress: 押している間 AnimatedScale で少し縮める
    return const Placeholder(fallbackHeight: 48);
  }
}
