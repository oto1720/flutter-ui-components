# カリキュラム — Flutter UI Components Lab

- **対象**: 初心者〜中級者（Flutter に少し触れたことがある人）
- **形式**: ハンズオン中心
- **所要時間**: 約 2.5 時間
- **ゴール**: 各参加者が自分の UI コンポーネント集（UI Kit）を Widgetbook 上で確認できる状態になる

## コンセプト：知る → 作る → 使う

1. **知る** — Flutter の Widget とコンポーネント設計の基本を知る
2. **作る** — Button / TextField / Card などを自分で実装する
3. **使う** — 作ったコンポーネントを組み合わせて 1 つの画面にし、Widgetbook でカタログ化する

## タイムテーブル

| 時間 | セクション | 内容 |
|---|---|---|
| 20分 | ① Widget とコンポーネント設計の基礎 | StatelessWidget / StatefulWidget、Row / Column / Stack / Container、Widget の分割と責務 |
| 30分 | ② 再利用可能な Widget を作る | `AppButton` を題材に、コンストラクタでの値渡し、`required` / optional、`enum` でのバリエーション管理、ローディング状態 |
| 20分 | ③ Theme・デザインシステム | `ColorScheme` / `TextTheme` / Material 3、共通カラー・余白・角丸、アプリ全体のデザイン統一 |
| 25分 | ④ Widgetbook 導入・設定 | 別エントリ（`-t`）での起動、本体から切り離して部品を確認するという考え方 |
| 30分 | ⑤ Catalog へのコンポーネント登録 | `WidgetbookComponent` / `WidgetbookUseCase` でバリエーションを登録・確認 |
| 25分 | ⑥ 各自で UI Kit を拡張 | `AppCard` / `AppChip` などを実装 → Widgetbook に登録 → Pull Request |

## 進め方（GitHub 運用）

1. 講師が環境構築済みのリポジトリを用意（このリポジトリ）
2. 参加者は `start` ブランチから作業ブランチを作成
3. [Issues](../../issues) のタスクを 1 つずつ実装
4. Pull Request を出す
5. 最後に全員のコンポーネントを Catalog に統合

## ハンズオンで作るコンポーネント

| コンポーネント | 実装内容 |
|---|---|
| `AppButton` | Primary / Secondary / Outlined / Disabled / Loading |
| `AppTextField` | 通常 / エラー / パスワード |
| `AppCard` | タイトル・説明・画像 |
| `AppChip` | 選択状態 / 通常状態 |
| `AppSection` | セクションの共通レイアウト |

重要なのは、コードを書くだけでなく **「なぜこの設計にしたのか」** を理解すること。
（例：色違いのボタンを別 Widget にせず、1 つの `AppButton` に `enum` でバリエーションを持たせる理由）

## 発展（時間が余ったら / 次回）

- **Golden Test** — UI の見た目を画像で回帰テスト
- **Widgetbook のコード生成** — アノテーション + `build_runner`
- **Freezed** — 状態・データモデルの定義
- **Melos** — 共通 UI パッケージのモノレポ管理
