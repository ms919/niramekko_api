### 環境構築手順

1. gemのインストール

```
$ bundle install
```

2. テーブル作成

```
$ rails db:migrate
```

※全環境postgresqlを使用しています。
ローカル環境にpostgresインストール済み、DB、ユーザー作成済みの想定です。
DB、ユーザー名は`config/database.yml`を参照してください。

3. アプリケーションの起動

```
$ rails s
```

### credentials.yml.encの管理内容

OAuth認証を試す場合は`credentials.yml.enc`を削除し、`rails credentials:edit`で以下のように編集してください。

```
omniauth:
  twitter:
    api_key: [TWITTER_API_KEY]
    api_secret: [TWITTER_API_SECRET]
  google:
    client_id: [GOOGLE_CLIENT_ID]
    client_secret: [GOOGLE_CLIENT_SECRET]
  tiktok:
    client_key: [TIKTOK_CLIENT_KEY]
    client_secret: [TIKTOK_CLIENT_SECRET]
```
