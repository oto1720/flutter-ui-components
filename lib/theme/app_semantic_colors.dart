import 'package:flutter/material.dart';

import 'app_colors.dart';

/// ColorScheme に無い「意味色」（成功・警告）を Theme に載せるための拡張。
///
/// Material の ColorScheme には error はあるが success / warning が無い。
/// そこで [ThemeExtension] を使って Theme に追加し、コンポーネントからは
/// `AppSemanticColors.of(context).success` のように取り出す。
/// Light / Dark で別の値を持てるので、色をコンポーネントに直書きせずに済む。
///
/// 各色は ColorScheme と同じ 4 点セットで持つ:
/// - `success` … 塗りつぶしに使う濃い色 / `onSuccess` … その上の文字色
/// - `successContainer` … 淡い背景色 / `onSuccessContainer` … その上の文字色
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
  });

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;

  static const light = AppSemanticColors(
    success: AppColors.successLight,
    onSuccess: Colors.white,
    successContainer: AppColors.successContainerLight,
    onSuccessContainer: AppColors.onSuccessContainerLight,
    warning: AppColors.warningLight,
    onWarning: Colors.white,
    warningContainer: AppColors.warningContainerLight,
    onWarningContainer: AppColors.onWarningContainerLight,
  );

  static const dark = AppSemanticColors(
    success: AppColors.successDark,
    onSuccess: AppColors.onSuccessDark,
    successContainer: AppColors.successContainerDark,
    onSuccessContainer: AppColors.onSuccessContainerDark,
    warning: AppColors.warningDark,
    onWarning: AppColors.onWarningDark,
    warningContainer: AppColors.warningContainerDark,
    onWarningContainer: AppColors.onWarningContainerDark,
  );

  /// Theme から取り出す。AppTheme を使っていない場合は明るさに応じた既定値を返す。
  static AppSemanticColors of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppSemanticColors>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
    );
  }

  // テーマ切り替え時に色をなめらかに補間するために必要。
  @override
  AppSemanticColors lerp(AppSemanticColors? other, double t) {
    if (other == null) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(successContainer, other.successContainer, t)!,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t)!,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t)!,
    );
  }
}
