# CIRCLECAST

![CIRCLECASTのロゴ](https://github.com/futa4095/private-podcast/assets/69447745/c8ab19cc-2d7a-4c1b-8f28-bacd8e36874b)

## 概要

[CIRCLECAST](https://circlecast.net/)はプライベートグループ向けのポッドキャストサービスを提供するRailsアプリケーションです。ユーザーは招待制のグループでポッドキャストをアップロードし、エピソードを共有することができます。シンプルなインターフェースと使いやすい管理機能を備え、モバイルデバイスにも対応したレスポンシブデザインを採用しています。

## スクリーンショット

![スクリーンショット1](https://github.com/futa4095/private-podcast/assets/69447745/96e18f5a-877f-4b18-a658-ca00fad5400f)
![スクリーンショット2](https://github.com/futa4095/private-podcast/assets/69447745/91fb2ebb-023b-4284-8b8b-225ef8c1a825)
![スクリーンショット3](https://github.com/futa4095/private-podcast/assets/69447745/a9cf8858-eee5-465d-acd8-75196b216755)

## 環境

- Ruby 3.4
- Rails 7.0
- データベース: PostgreSQL
- 認証: Devise
- ファイルアップロード: Active Storage

## セットアップ

1. リポジトリをクローンします。

```sh
git clone https://github.com/futa4095/private-podcast
cd private-podcast
```

1. Gemをインストール、データベースの作成を実行します。

```sh
bin/setup
```

1. 必要に応じて、データベースに初期データを投入します。

```sh
rails db:seed
```

1. サーバーを起動します。

```sh
bin/dev
```

## テスト

1. RSpecを使用してテストを実行します。

```sh
bin/rspec
```

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。詳細についてはLICENSEファイルを参照してください。
