/// 余白・角丸の共通定数（ミニマル・モノクロ版）。
///
/// 余白を 8 の倍数などに揃えると、画面全体のリズムが整う。
/// `SizedBox(height: 16)` のようなマジックナンバーを散らばらせない。
///
/// このテーマでは角丸を大きめにして、影を使わない代わりに
/// 「丸み」でやわらかさを出している。
class AppSpacing {
  AppSpacing._();

  // 余白（padding / margin / gap）
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  // 角丸
  static const double radiusSm = 14; // 入力欄・タグなど
  static const double radiusMd = 20; // カードなど
  static const double radiusLg = 28; // ダイアログ・ボトムシート・検索欄など
}
