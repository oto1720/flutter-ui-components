import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_input_border.dart';
import 'app_semantic_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// アプリ全体のテーマ（ミニマル・モノクロ版）。
///
/// `main` ブランチの標準的な Material 3 テーマとの違い:
/// - 色: seed からの自動生成をやめ、黒・白・灰＋アクセント 1 色を手で割り当てる
/// - 形: ボタンはピル型（両端が完全な丸）、カードや入力欄は大きめの角丸
/// - 影: ほぼ使わない。面の区別は「薄い灰色の塗り」と「細い線」で付ける
/// - 文字: 見出しを大きく太くして、色ではなく文字でメリハリを付ける
///
/// コンポーネント側のコードはほとんど変えていない。
/// 「見た目の決定を Theme に集めておくと、テーマの差し替えだけで
/// アプリ全体の印象を変えられる」ことを確かめるためのブランチ。
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(_lightScheme, AppSemanticColors.light);
  static ThemeData get dark => _build(_darkScheme, AppSemanticColors.dark);

  // ---- 配色 ----
  // primary = 黒（Dark では白）。「一番重要なもの」を無彩色にするのがモノクロの肝。
  // tertiary = アクセント色。使う場所を絞るほど効く。
  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.ink,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.gray200,
    onPrimaryContainer: AppColors.ink,
    secondary: AppColors.gray600,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.gray100,
    onSecondaryContainer: AppColors.ink,
    tertiary: AppColors.accentLight,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.accentContainerLight,
    onTertiaryContainer: AppColors.onAccentContainerLight,
    error: AppColors.errorLight,
    onError: AppColors.white,
    errorContainer: AppColors.errorContainerLight,
    onErrorContainer: AppColors.onErrorContainerLight,
    surface: AppColors.white,
    onSurface: AppColors.ink,
    onSurfaceVariant: AppColors.gray600,
    surfaceContainerLowest: AppColors.white,
    surfaceContainerLow: AppColors.gray50,
    surfaceContainer: AppColors.gray100,
    surfaceContainerHigh: AppColors.gray150,
    surfaceContainerHighest: AppColors.gray200,
    outline: AppColors.gray300,
    outlineVariant: AppColors.gray200,
    inverseSurface: AppColors.ink,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.white,
    shadow: Colors.black,
    scrim: Colors.black,
    // Material 3 は面に primary の色味を薄く重ねる。モノクロでは不要なので消す。
    surfaceTint: Colors.transparent,
  );

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white,
    onPrimary: AppColors.ink,
    primaryContainer: AppColors.gray800,
    onPrimaryContainer: AppColors.white,
    secondary: AppColors.gray400,
    onSecondary: AppColors.ink,
    secondaryContainer: AppColors.gray850,
    onSecondaryContainer: AppColors.white,
    tertiary: AppColors.accentDark,
    onTertiary: AppColors.ink,
    tertiaryContainer: AppColors.accentContainerDark,
    onTertiaryContainer: AppColors.onAccentContainerDark,
    error: AppColors.errorDark,
    onError: AppColors.onErrorDark,
    errorContainer: AppColors.errorContainerDark,
    onErrorContainer: AppColors.onErrorContainerDark,
    surface: AppColors.gray950,
    onSurface: AppColors.white,
    onSurfaceVariant: AppColors.gray400,
    surfaceContainerLowest: Colors.black,
    surfaceContainerLow: AppColors.gray900,
    surfaceContainer: AppColors.gray850,
    surfaceContainerHigh: AppColors.gray800,
    surfaceContainerHighest: AppColors.gray700,
    outline: AppColors.gray700,
    outlineVariant: AppColors.gray800,
    inverseSurface: AppColors.white,
    onInverseSurface: AppColors.ink,
    inversePrimary: AppColors.ink,
    shadow: Colors.black,
    scrim: Colors.black,
    surfaceTint: Colors.transparent,
  );

  static ThemeData _build(ColorScheme scheme, AppSemanticColors semantic) {
    // ボタンはすべてピル型。StadiumBorder は「高さの半分」を角丸にする形。
    const pill = StadiumBorder();

    // 入力欄の枠。普段は線なし（灰色の塗りだけ）、フォーカス時だけ線を出す。
    AppFilledInputBorder inputBorder([BorderSide side = BorderSide.none]) =>
        AppFilledInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: side,
        );

    // まず色と文字だけのテーマを作る。こうすると、端末ごとの標準フォントと
    // 文字色が合成された「完成形の文字スタイル」を base.textTheme から取り出せる。
    // 下の部品別テーマでは、それを土台にして使う。
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // 色は持たせず、大きさ・太さだけ上書きする（色は ColorScheme から付く）。
      textTheme: TextTheme(
        headlineSmall: AppTextStyles.heading,
        titleLarge: AppTextStyles.heading.copyWith(fontSize: 22),
        titleMedium: AppTextStyles.title,
        bodyLarge: AppTextStyles.body.copyWith(fontSize: 16),
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
        labelLarge: AppTextStyles.label,
      ),
    );
    final text = base.textTheme;

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      extensions: [semantic],
      // 文字入力のカーソルと選択範囲にアクセント色を使う。
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.tertiary,
        selectionColor: scheme.tertiary.withValues(alpha: 0.25),
        selectionHandleColor: scheme.tertiary,
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, thickness: 1),

      // ---- ボタン ----
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: pill),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: pill,
          side: BorderSide(color: scheme.outline, width: 1.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: pill),
      ),
      // elevated だけは「浮いている」ことが役割なので、控えめな影を残す。
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: pill,
          backgroundColor: scheme.brightness == Brightness.light
              ? scheme.surface
              : scheme.surfaceContainerHigh,
          foregroundColor: scheme.onSurface,
          elevation: 3,
          shadowColor: Colors.black.withValues(alpha: 0.4),
        ),
      ),
      // FAB は画面に 1 つだけの主役なので、アクセント色を使う。
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.tertiary,
        foregroundColor: scheme.onTertiary,
        elevation: 2,
        highlightElevation: 2,
        shape: pill,
        extendedTextStyle: text.labelLarge,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: scheme.primary,
          selectedForegroundColor: scheme.onPrimary,
          side: BorderSide(color: scheme.outline),
        ),
      ),

      // ---- 入力 ----
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        // ラベルが内側に入る分、上下の余白は控えめにする。
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 10,
        ),
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(BorderSide(color: scheme.primary, width: 1.5)),
        errorBorder: inputBorder(BorderSide(color: scheme.error, width: 1.5)),
        focusedErrorBorder: inputBorder(
          BorderSide(color: scheme.error, width: 2),
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        floatingLabelStyle: TextStyle(color: scheme.onSurface),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
      switchTheme: const SwitchThemeData(
        // 枠線を消して、塗りだけのすっきりしたスイッチにする。
        trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      chipTheme: ChipThemeData(
        shape: pill,
        side: BorderSide.none,
        backgroundColor: scheme.surfaceContainer,
        selectedColor: scheme.primary,
        showCheckmark: false,
        // 選択中は黒地に白文字へ反転させる。
        labelStyle: text.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? scheme.onPrimary
                : scheme.onSurface,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
      ),

      // ---- 面（カード・ダイアログなど） ----
      // 影の代わりに細い線で面を区切る。
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        dragHandleColor: scheme.outline,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        textStyle: text.bodySmall?.copyWith(color: scheme.onInverseSurface),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: scheme.tertiary,
        textColor: scheme.onTertiary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.tertiary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: Colors.transparent,
      ),

      // ---- ナビゲーション ----
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0, // スクロールしても色を変えない
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        elevation: 0,
        // 選択中のタブは黒いピルに白いアイコン。
        indicatorColor: scheme.primary,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.onPrimary
                : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? text.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                )
              : text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.onSurface,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: scheme.outlineVariant,
        labelStyle: text.labelLarge,
        unselectedLabelStyle: text.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      listTileTheme: ListTileThemeData(iconColor: scheme.onSurface),
    );
  }
}
