import 'package:flutter/material.dart';

import '../../theme/app_semantic_colors.dart';
import '../../theme/app_spacing.dart';

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
///   これは Flutter 標準ボタンの慣習に合わせている。
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

  /// true の間はスピナーを表示し、押せなくする。ボタンの幅は変わらない。
  final bool isLoading;

  /// 親の幅いっぱいに広げる（いわゆる block button）。
  final bool isFullWidth;

  /// 押している間だけ少し縮む「押した感触」を付ける。
  final bool animatePress;

  /// ラベルの前後に置くアイコン（任意）。
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    // ローディング中は押せないようにする（onPressed を無効化）。
    final effectiveOnPressed = isLoading ? null : onPressed;
    final style = _styleFor(context);
    final child = _buildChild();

    Widget button = switch (variant) {
      AppButtonVariant.filled => FilledButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.tonal => FilledButton.tonal(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.elevated => ElevatedButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
    };

    if (animatePress && effectiveOnPressed != null) {
      button = _PressScale(child: button);
    }

    // 全幅指定なら横いっぱいに広げる。
    return isFullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }

  /// [variant] × [tone] × [size] から ButtonStyle を組み立てる。
  ButtonStyle _styleFor(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semantic = AppSemanticColors.of(context);

    // tone ごとの 4 色（濃い色 / その上の文字 / 淡い色 / その上の文字）。
    // primary は null のままにして、各ボタンの標準色（Theme）に任せる。
    final (Color? main, Color? onMain, Color? container, Color? onContainer) =
        switch (tone) {
          AppButtonTone.primary => (null, null, null, null),
          AppButtonTone.danger => (
            scheme.error,
            scheme.onError,
            scheme.errorContainer,
            scheme.onErrorContainer,
          ),
          AppButtonTone.success => (
            semantic.success,
            semantic.onSuccess,
            semantic.successContainer,
            semantic.onSuccessContainer,
          ),
        };

    // 大きさは全 variant で共通。形（角丸）はここでは決めず、Theme の
    // filledButtonTheme などに任せる。テーマを差し替えるだけで形も変わる。
    final padding = EdgeInsets.symmetric(horizontal: size.horizontalPadding);
    final minimumSize = Size(64, size.height);
    // Theme の labelLarge を土台にして、大きさだけ変える（太さを失わない）。
    final textStyle = theme.textTheme.labelLarge?.copyWith(
      fontSize: size.fontSize,
    );
    // デスクトップ / Web でも高さが詰まらないよう、密度を固定する。
    const density = VisualDensity.standard;

    return switch (variant) {
      AppButtonVariant.filled => FilledButton.styleFrom(
        backgroundColor: main,
        foregroundColor: onMain,
        padding: padding,
        minimumSize: minimumSize,
        textStyle: textStyle,
        visualDensity: density,
      ),
      AppButtonVariant.tonal => FilledButton.styleFrom(
        backgroundColor: container,
        foregroundColor: onContainer,
        padding: padding,
        minimumSize: minimumSize,
        textStyle: textStyle,
        visualDensity: density,
      ),
      AppButtonVariant.elevated => ElevatedButton.styleFrom(
        foregroundColor: main,
        padding: padding,
        minimumSize: minimumSize,
        textStyle: textStyle,
        visualDensity: density,
      ),
      AppButtonVariant.outlined => OutlinedButton.styleFrom(
        foregroundColor: main,
        padding: padding,
        minimumSize: minimumSize,
        textStyle: textStyle,
        visualDensity: density,
      ).copyWith(
        // 枠線も tone の色にする。無効時は null を返して標準の薄い枠線に任せる。
        side: main == null
            ? null
            : WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.disabled)
                    ? null
                    : BorderSide(color: main),
              ),
      ),
      AppButtonVariant.text => TextButton.styleFrom(
        foregroundColor: main,
        padding: padding,
        minimumSize: minimumSize,
        textStyle: textStyle,
        visualDensity: density,
      ),
    };
  }

  /// ボタンの中身。アイコン＋ラベル。ローディング中はその上にスピナーを重ねる。
  Widget _buildChild() {
    // アイコンが無ければラベルだけにする（余計な Row を作らない）。
    final Widget content = (leadingIcon == null && trailingIcon == null)
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: size.iconSize),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(child: Text(label)),
              if (trailingIcon != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Icon(trailingIcon, size: size.iconSize),
              ],
            ],
          );

    if (!isLoading) return content;

    // ローディング中は中身を「見えないが場所は取る」状態にして、
    // その上にスピナーを重ねる。こうするとボタンの幅・高さが変わらず、
    // 押した瞬間に周りのレイアウトがずれない。
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: content,
        ),
        Builder(
          builder: (context) => SizedBox.square(
            dimension: size.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              // ボタンの文字色（無効時の色）に合わせる。
              color: IconTheme.of(context).color,
              // 見えなくなったラベルの代わりに読み上げ用の名前を付ける。
              semanticsLabel: label,
            ),
          ),
        ),
      ],
    );
  }
}

/// 押している間だけ子を少し縮めるラッパー。
///
/// タップ処理そのものは中のボタンに任せ、ここでは [Listener] で
/// 「指が触れた／離れた」だけを横から見ている。そのため、リップルや
/// キーボード操作・読み上げなど、標準ボタンの機能はそのまま残る。
class _PressScale extends StatefulWidget {
  const _PressScale({required this.child});

  final Widget child;

  @override
  State<_PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<_PressScale> {
  bool _pressed = false;

  void _set(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}
