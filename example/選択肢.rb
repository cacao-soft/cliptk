#
# [VXAce] コマンドラインから引数を受け取ってイベントコマンドを作る
#   cliptk 選択肢.rb １ ２ ３
#

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
