#!/bin/bash

# このバージョンはDockerfileに書いてある内容
ruby_version=3.2.2
node_version=20
default_option="--skip-bundle --database=postgresql"

echo "以下でRailsをインストールします。"
echo "Rubyのバージョン: $ruby_version"
echo "Nodeのバージョン: $node_version"
echo "デフォルトオプション: $default_option"

read -p "他に必要なオプションがあれば入力してください > " other_option

echo "-------------------------------------------"

read -p "この内容で良いですか？ (yes/no): " confirmation
if [ "$confirmation" != "yes" ]; then
  echo "バージョンを変える場合は、Dockerfile.tmpを編集してください。"
  echo "デフォルトオプションを変える場合は、scripts/setup_rails.shを編集してください。"
  echo "終了します。"
  exit 1
fi

echo "-------------------------------------------"
echo "Dockerをビルドしています。"
echo "docker build -t rails-new-template -f Dockerfile.tmp ."
docker build -t rails-new-template -f Dockerfile.tmp .

echo "Railsをインストールしています。"
echo "docker run --rm -v ${PWD}:/app rails-new-template rails new . --force --database=postgresql --skip-bundle $other_option"
docker run --rm -v ${PWD}:/app rails-new-template rails new . --force --database=postgresql --skip-bundle $other_option
