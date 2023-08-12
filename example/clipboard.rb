#
# クリップボードへの入出力
#

=begin

  Clipboard.get
    クリップボードのデータを取得します。
    VXAce 以前はRubyオブジェクト、MV 以降はJSON文字列で取得します。
    JSON文字列は JSON.parse(json) でRubyオブジェクトに変換できます。

  Clipboard.data
    クリップボードのデータを取得します。
    JSON文字列はRubyオブジェクトに変換されます。
  
  Clipboard << データ
  Clipboard(*フォーマット) << データ
  Clipboard.set(*フォーマット, データ)
    クリップボードにデータを書き込みます。
    フォーマットを省略した場合は、VXAce か MZ のデータとして書き込みます。
      :XP, :VX, :VXA, :MV, :MZ, :TXT
    XP～VXAは、すべての形式で保持するので指定する意味は薄いかと思います。
    自動判別は VXAce と MZ のデータ構造を使用します。
    Rubyオブジェクトは JSON.generate(obj) でJSON文字列に変換できます。

  Clipboard.type
    クリップボードのデータ形式(Symbol)を取得します。
      :XP, :VX, :VXA, :MV, :MZ

  Clipboard.format
    標準および登録済みのクリップボード形式を取得します。この値は変動します。

=end

# クリップボードのデータを取得
#   XP,VX,VXAceのデータは、RPG::xxxなどのオブジェクト
#   MV,MZのデータは、{"key"=>123}などのオブジェクト
clipdata = Clipboard.data

case Clipboard.type
when :MV
  Clipboard(:MZ) << clipdata
  # JSON文字列であればMZデータとして書き込まれる
  # Clipboard << Clipboard.get
when :MZ
  Clipboard(:MV, Clipboard.format, :TXT) << clipdata
  # MV 用に変換するにはフォーマットの指定が必要
  # Clipboard(:MV) << JSON.parse(Clipboard.get)
else
  Clipboard << clipdata
end
