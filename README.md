# Flutter UI Components Lab 🧩

**〜自分だけの UI Kit を作ろう〜**

福大ピアプロの勉強会用テンプレート。単に Widget を紹介するのではなく、
**再利用可能な UI コンポーネントを設計し、[Widgetbook](https://widgetbook.io/) でカタログ化する**
ことをゴールにした、ハンズオン形式の講座リポジトリです（Web でいう Storybook に相当）。

最終的に、ここで作ったコンポーネントは **サークルの共通 UI ライブラリ** として今後のチーム開発でも使えます。

```dart
AppButton(
  label: 'ログイン',
  onPressed: () {},
)

// 見た目の強さ（variant）と意味（tone）は別々に指定できる
AppButton(
  label: '削除',
  variant: AppButtonVariant.outlined,
  tone: AppButtonTone.danger,
  onPressed: () {},
)
```

## 🎯 到達目標

- Flutter の基本 Widget の役割を理解する
- 再利用可能な UI コンポーネントを設計・実装できる（`enum` / `required` によるバリエーション管理）
- `ThemeData` でアプリ全体のデザインを統一できる（Material 3）
- Widgetbook で部品単位の UI カタログを作れる

## 📁 構成

```
lib/
├── main.dart              # 作ったコンポーネントを並べたサンプル画面（「使う」成果物）
├── components/            # 再利用コンポーネント
│   ├── buttons/           # AppButton（variant × tone × size / loading / disabled）ほか
│   ├── text_fields/       # AppTextField（通常 / エラー / パスワード）
│   ├── cards/             # AppCard（タイトル・説明・画像）
│   ├── chips/             # AppChip（選択 / 未選択）
│   └── layout/            # AppSection（見出し＋中身の共通レイアウト）
└── theme/                 # デザインシステム
    ├── app_colors.dart    # カラーパレット（seed と意味色）
    ├── app_semantic_colors.dart  # success / warning を Theme に載せる ThemeExtension
    ├── app_spacing.dart   # 余白・角丸
    ├── app_text_styles.dart
    └── app_theme.dart     # ThemeData（Material 3 / Light・Dark / 部品別テーマ）

widgetbook/
└── main.dart              # UI カタログ（部品を単体でプレビュー）

test/
└── components/            # コンポーネントの widget test
```

## 🚀 セットアップ

必要環境: Flutter 3.38 以降 / Dart 3.10 以降

```bash
flutter pub get
```

### サンプルアプリを起動

```bash
flutter run                       # 端末 / エミュレータ
flutter run -d chrome             # ブラウザ
```

### Widgetbook（UI カタログ）を起動

```bash
flutter run -t widgetbook/main.dart -d chrome
```

左のツリーからコンポーネントを選ぶと、Primary / Disabled / Loading などの状態を切り替えて確認できます。
上部のツールバーでテーマや文字サイズも変えられます。

### Widget Previewer（書きながら手元で確認）

```bash
flutter widget-preview start
```

Flutter 標準の [Widget Previewer](https://flutter.dev/to/widget-previews) です。追加パッケージは要りません。
コンポーネントのファイルに `@AppPreview(...)` を付けた関数を書くと、Light / Dark の 2 枚がブラウザに表示されます（共通設定は `lib/previews/app_preview.dart`）。
いまは `AppButton` / `AppCard` / `AppChip` にプレビューがあります。

| | Widgetbook | Widget Previewer |
|---|---|---|
| 用途 | チームで見る UI カタログ | 実装中の手元確認 |
| 書く場所 | `widgetbook/main.dart` | コンポーネントと同じファイル |
| 状態の切り替え | Knobs で対話的に | 状態ごとにプレビュー関数を並べる |

### テスト

```bash
flutter test
flutter analyze
```

## 🧑‍💻 ハンズオンの進め方

このリポジトリは **ハイブリッド型** です。

| ブランチ | 中身 |
|---|---|
| `main` | 完成リファレンス（全コンポーネント実装済み）。詰まったらここを見本に。 |
| `start` | 雛形のみ（コンポーネントの中身が `TODO`）。**ここから実装を始める。** |
| `theme/minimal-mono` | `main` と同じコンポーネントに別デザインのテーマ（ミニマル・モノクロ）を当てた版。テーマ差し替えの見本。 |

おすすめの流れ:

1. `git switch start` でハンズオン開始地点へ
2. 自分の作業ブランチを切る（例: `git switch -c feature/app-button`）
3. [Issues](../../issues) のタスク（AppButton / AppTextField / …）を 1 つ実装
4. Widget Previewer で見ながら実装し、仕上がったら Widgetbook に UseCase を登録
5. Pull Request を出す → 全員のコンポーネントを Catalog に統合

## 📚 カリキュラム

講座の詳細なタイムテーブルは [`docs/curriculum.md`](docs/curriculum.md) を参照（2.5 時間 / ハンズオン中心）。

コンセプトは **知る → 作る → 使う**。

## 🔭 発展（次の一歩）

- **Golden Test** — UI の見た目を画像で保証する回帰テスト（`test/components/app_button_test.dart` の振る舞いテストから発展）
- **Widgetbook のコード生成** — `@widgetbook.UseCase` アノテーション + `build_runner` で UseCase を自動収集
- **Freezed** — UI の状態やデータモデルの定義
- **Melos** — モノレポで共通 UI パッケージを管理
