# Airryr_Web

https://github.com/jyllsarta/airryr のMackerel連携から飛んでくるWebhookを受け取って、Twitterでアラートを飛ばさせるWebサーバ

## install

```shell
git clone https://github.com/jyllsarta/airryr_web.git
cd airryr_web
bundle install
```

### (あるならスキップ) TwitterのOAuthトークン取得

https://qiita.com/kngsym2018/items/2524d21455aac111cdee
この辺を参考にTwitterのdevelopper accountとアプリを登録して、
https://github.com/jugyo/get-twitter-oauth-token
このgemなどを利用して作成したアプリのConsmer Token, Consumer Secret, 発言させたいアカウントの Access Token, Access Secret を取得する

```shell
mv dotenv.example .env
vim .env
# TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET, TWITTER_ACCESS_KEY, TWITTER_ACCESS_TOKEN_SECRET を編集
```


### 疎通確認

ローカルからMackerelのWebhookと同じリクエストを送信して動作確認ができます

```
bundle exec ruby airryr_web.rb & # run server
bundle exec ruby post_local.rb
# → twitterに発言が飛ぶ
```

## run

```shell
bundle exec ruby airryr_web.rb
```
