# ベースとして使用するイメージ名（DockerHubからダウンロードされる）
FROM ruby:3.2.2-alpine

# 利用可能なパッケージのリストを更新するコマンドを実行
RUN apk update

# パッケージをインストールするコマンドを実行
# M1 Macではnokogiriのビルドにbuild-baseが必要
RUN apk add g++ make mysql-dev tzdata build-base

# コンテナを起動した時の作業ディレクトリを/appにする
WORKDIR /app

# PC上のGemfile を .（/app）にコピー
COPY Gemfile .

# バイナリのgemではなく、ソースコードからgemをビルドする設定
RUN bundle config set force_ruby_platform true

# bundle installでGemfileに記述されているgemをインストール
RUN bundle install