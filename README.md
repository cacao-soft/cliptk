# cliptk

RPGツクールのクリップボード取得 CLI ツール (VX,VXAce,MV,MZ 対応)

## ダウンロード

- [リリースページ](https://github.com/cacao-soft/cliptk/releases/)からダウンロード

## 使い方

```sh
cliptk help
```

- `cliptk`
  - クリップボードの内容を別のツクールに貼付可能なデータに変換
    - XP, VX, VXAce -\> XP, VX, VXAce (データ構造がVXAceと同じもののみ)
    - MV \<-\> MZ (データ構造が同じもののみ)
  - MV, MZ のデータをテキストエディタにも貼付可能にする
    - MV, MZ -\> JSON
    - JSON -\> MZ
- `cliptk filename`
  - スクリプトファイルを実行
- `cliptk V`
  - クリップボードの内容を表示
- `cliptk V filename`
  - ファイルの内容を表示
- `cliptk S filename`
  - クリップボードの内容をファイルに保存
- `cliptk L filename`
  - ファイルからクリップボードの内容を復元

> スクリプトファイルの拡張子を`ctk`などに変更し関連付けするとダブルクリックでスクリプトが実行できるようになります。

## スクリプト

```ruby
# クリップボードのデータを取得
obj = Clipboard.data
# クリップボードへデータの書き込み
Clipboard << obj

# コマンドライン引数の取得
# ファイル名以降の引数のみ取得可能
p ARGV

# 実行時の各パスを取得する
p __exe__      # 実行ファイル
p __file__     # スクリプト
p __dir__      # スクリプトフォルダ
p __project__  # プロジェクトファイル

# オブジェクトをファイルへ保存
save_data(obj, "filename")
# オブジェクトをファイルから復元
obj = load_data("filename")

# JSON 文字列から Hash オブジェクトを生成する
p JSON.parse('{"key":123}')
# オブジェクト(Hash,Array)から JSON 文字列を生成する
p JSON.generate([1, {"k" => 123}])
# オブジェクトをJSONファイルから生成
obj = JSON.read("filename")
# オブジェクトをJSONファイルで保存
JSON.save(obj, "filename")

# ファイル一覧の取得
p Dir.glob("Data/*.rvdata2")
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

## 使用ライブラリ

- [mruby](https://github.com/mruby/mruby): Copyright (c) 2010-2021 mruby developers
