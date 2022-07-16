#
# [VXAce] イベントの簡単作成的なものを作成します。
#

print "取得する金額："
gold = gets.to_i

# cliptk S で保存したイベントを読み込む
event = load_data(File.join(__dir__, "宝箱.rvdata2"))
# 読み込んだイベントの編集
event.name = "宝箱 (#{gold}Ｇ)"
event.pages[0].list.each do |command|
  case command.code
  when 125  # 所持金の増減
    command.parameters[2] = gold
  when 401
    command.parameters[0].sub!(/\d+\\G/, "#{gold}\\G")
  end
end
# 編集後のデータをクリップボードへ戻す
Clipboard << event


=begin

  gets      入力を受け取る

  __exe__   実行ファイルのパス (cliptk.exe)
  __file__  スクリプトパス (cliptk に渡した引数)
  __dir__   スクリプトのあるフォルダのパス
  Dir.pwd   カレントディレクトリのパス

=end
