# RSS Notification via im.kayac.com

RSS feed を im.kayac.com 経由で通知するツール

## 使い方

### 準備

```
$ git clone git@github.com:mizoR/rss-notify-via-im-kayac.git
$ cd rss-notify-via-im-kayac
$ bundle install --path vendor/bundle
```

### ウェブコンソール起動

```
$ bundle exec foreman start -c web=1
$ open http://localhost:5000/
```

#### Basic認証を有効にして起動

```
$ BASIC_USERNAME=<your_username> BASIC_PASSWORD=<your_password> \
    bundle exec foreman start -c web=1
```

### RSS購読開始

```
$ IM_KAYAC_USERNAME=<im_kayac_username> IM_KAYAC_SECRET=<im_kayac_secret> \
    bundle exec foreman start -c clock=1
```

## Herokuで使う

### 準備

```
$ bundle exec heroku create <this-application-name>
$ bundle exec heroku addons:add heroku-postgresql
$ bundle exec heroku config:add \
    BASIC_USERNAME=<your_username> BASIC_PASSWORD=<your_password> \
    IM_KAYAC_USERNAME=<im_kayac_username> IM_KAYAC_SECRET=<im_kayac_secret>
$ git push heroku master
$ bundle exec heroku run rake db:migrate
```

### ウェブコンソールを起動

```
$ bundle exec heroku scale web=0 clock=0  # 全てのプロセスを停止
$ bundle exec heroku scale web=1 clock=0  # webプロセスを起動
$ bundle exec heroku open
```

### RSS購読開始

```
$ bundle exec heroku scale web=0 clock=0  # 全てのプロセスを停止
$ bundle exec heroku scale web=0 clock=1  # webプロセスを起動
```

