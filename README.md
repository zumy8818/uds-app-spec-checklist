# App Overview

うぶやまデジタルサービス（UDS）のアプリ管理ツール。
制作・運用しているアプリの概要をDBで管理し、スマホからいつでも確認できる。

## 機能

- アプリ一覧表示・検索・ステータスフィルター
- 詳細表示（スタック・URL・GitHub・引継ぎメモ）
- 新規登録・編集・削除
- Supabase（PostgreSQL）連携、オフライン時はデモモードで動作

## セットアップ

### 1. Supabaseプロジェクト作成

1. [supabase.com](https://supabase.com) でプロジェクトを作成
2. SQL Editor で `supabase_setup.sql` を実行
3. Project Settings > API から URL と anon key を取得

### 2. 設定ファイル作成

```bash
cp config.example.js config.js
```

`config.js` を編集して自分のURLとキーを入力：

```js
window.SUPABASE_URL = 'https://xxxxxxxxxxxx.supabase.co';
window.SUPABASE_ANON_KEY = 'eyJxxxxxxxxxxxxxxxxxxxxxxxxxx';
```

> ⚠️ `config.js` は `.gitignore` に含まれています。GitHubにpushされません。

### 3. ブラウザで開く

`index.html` をブラウザで直接開くか、ローカルサーバーで起動。

```bash
# Pythonがある場合
python -m http.server 8080
# → http://localhost:8080
```

## ファイル構成

```
app-overview/
├── index.html          # メインアプリ
├── config.js           # Supabase接続情報（gitignore）
├── config.example.js   # 設定テンプレート
├── supabase_setup.sql  # DBテーブル定義
├── .gitignore
└── README.md
```

## DB スキーマ

| カラム | 型 | 説明 |
|---|---|---|
| id | bigint | 自動採番 |
| name | text | アプリ名 |
| status | text | 開発中 / 運用中 / 保守のみ / 停止 |
| description | text | 一言説明 |
| stack | text | 技術スタック |
| hosting | text | ホスティング先 |
| url | text | 本番URL |
| github | text | GitHubリポジトリ（例: zumy8818/xxx） |
| start_date | date | 開始日 |
| release_date | date | リリース日 |
| memo | text | 引継ぎメモ |
| created_at | timestamptz | 作成日時 |
| updated_at | timestamptz | 更新日時（自動） |

## 開発メモ

- ShopPC: `C:\dev\internal\dev\app-overview\`
- HomePC: `C:\dev\internal\dev\app-overview\`
- GitHub: `zumy8818/app-overview`
- Supabase接続情報: ローカルの `config.js`（gitignore済み）
