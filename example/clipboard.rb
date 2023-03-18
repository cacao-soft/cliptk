#
# クリップボードへの入出力
#

format = Clipboard.format
if Clipboard.type == :MZ
  # MV 用に変換するにはフォーマットの指定が必要
  Clipboard(:MV, format, :TXT) << Clipboard.data
else
  Clipboard << Clipboard.data
end

=begin

  Clipboard << データ
  Clipboard(*フォーマット) << データ
  Clipboard.set(*フォーマット, データ)
    クリップボードにデータを書き込み
    フォーマットを省略した場合は、VXAce か MZ のデータとして書き込みます。
      :XP, :VX, :VXA, :MV, :MZ, :TXT
    XP～VXAは、すべての形式で保持するので指定する意味は薄いかと思います。
    自動判別は VXAce と MZ のデータ構造を使用します。

  Clipboard.data
    クリップボードのデータを取得します。
    VXAce 以前は Rubyオブジェクト、MV 以降は JSON文字列で取得します。

  Clipboard.type
    クリップボードのデータ形式(Symbol)を取得します。
      :XP, :VX, :VXA, :MV, :MZ

  Clipboard.format
    標準および登録済みのクリップボード形式を取得します。この値は変動します。

=end
