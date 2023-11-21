# ベースとして使用するイメージ名（DockerHubからダウンロードされる）
FROM ruby:3.2.2-alpine

# 利用可能なパッケージのリストを更新するコマンドを実行
RUN apk update

# パッケージをインストールするコマンドを実行
RUN apk add g++ make mysql-dev tzdata gcompat

# コンテナを起動した時の作業ディレクトリを/appにする
WORKDIR /app

# PC上のGemfile を .（/app）にコピー
COPY Gemfile .
COPY Gemfile.lock .
# COPY vendor ./vendor

# gemの保存先をvendor/bundleに切り替える設定
# 通常は不要だが、ダウンロードしたgemをgitで管理するために設定している
# RUN bundle config --local path vendor/bundle
# bundle installでGemfileに記述されているgemをインストール
RUN bundle install
