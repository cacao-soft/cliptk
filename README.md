# cliptk

RPGツクールのクリップボード取得 CLI ツール (VX,VXAce,MV,MZ 対応)

## ダウンロード

- [リリースページ](https://github.com/cacao-soft/cliptk/releases/)からダウンロードする

## 使い方

```sh
cliptk help
```

## スクリプト

```ruby
# クリップボードのデータ取得
# 取得可能なデータは、イベント・イベントページ・イベントコマンドの３種類
# それぞれ RPG::Event, RPG::Event::Page, [RPG::EventCommand] のオブジェクト
obj = Clipboard.data

# クリップボードへデータ設定
Clipboard << obj

# コマンドライン引数の取得
# ファイル名以降の引数のみ取得可能
p ARGV

# JSON 文字列から Hash オブジェクトを生成する
p JSON.parse('{"key":123}')
# オブジェクト(Hash,Array)から JSON 文字列を生成する
p JSON.generate([1, {"k" => 123}])

# オブジェクトをファイルへ保存
save_data(obj, "filename")
# オブジェクトをファイルから復元
obj = load_data("filename")
```

### サンプル

次のコードをファイル名`script.rb`で保存する。

```ruby
params = ARGV
params = %w[選択肢Ａ 選択肢Ｂ 選択肢Ｃ 選択肢Ｄ] if params.empty?

commands = []
# 選択肢の表示
commands << RPG::EventCommand.new(102, 0, [params, 5])
# [] の場合
params.each_with_index do |s,i|
  commands << RPG::EventCommand.new(402, 0, [i, s])
  commands << RPG::EventCommand.new(0, 1)
end
# キャンセルの場合
commands << RPG::EventCommand.new(403)
commands << RPG::EventCommand.new(0, 1)
# 分岐終了
commands << RPG::EventCommand.new(404)

Clipboard << commands
```

コマンドライン上で次のような実行が可能。

```sh
# 引数なし
cliptk script.rb
# 引数あり
cliptk script.rb 選択肢１ 選択肢２
```

## ライセンス

本ツールを作成するにあたり以下のものを使用させていただきました。

- [mruby](https://github.com/mruby/mruby): Copyright (c) 2010-2021 mruby developers
- [RapidJSON](https://rapidjson.org/): Copyright (C) 2015 THL A29 Limited, a Tencent company, and Milo Yip.
