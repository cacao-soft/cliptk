#
# [MV] 宝箱イベントを作成
#

# イベントの簡単作成で宝箱を作成する。金額がわかりやすいように 1234 に設定する。
# 宝箱をクリップボードにコピーする。
# cliptk を実行するとデータが MV 用とテキストに変換される。
# エディタに貼り付けることができる。
# 1234 を検索して変数に変更する。
# 制御文字 \\xxx が使われているところは \\\\xxx に変更する。

puts "入手金額を半角数字で指定してください"
gold = gets.to_i

Clipboard.set(:MV, <<EV_DATA)
{"id":1,"name":"宝箱（#{gold}Ｇ）","note":"","pages":[{"conditions":{"actorId":1,"actorValid":false,"itemId":1,"itemValid":false,"selfSwitchCh":"A","selfSwitchValid":false,"switch1Id":1,"switch1Valid":false,"switch2Id":1,"switch2Valid":false,"variableId":1,"variableValid":false,"variableValue":0},"directionFix":true,"image":{"characterIndex":0,"characterName":"!Chest","direction":2,"pattern":1,"tileId":0},"list":[{"code":250,"indent":0,"parameters":[{"name":"Chest1","pan":0,"pitch":100,"volume":90}]},{"code":205,"indent":0,"parameters":[0,{"list":[{"code":36},{"code":17},{"code":15,"parameters":[3]},{"code":18},{"code":15,"parameters":[3]},{"code":0}],"repeat":false,"skippable":false,"wait":true}]},{"code":505,"indent":0,"parameters":[{"code":36}]},{"code":505,"indent":0,"parameters":[{"code":17}]},{"code":505,"indent":0,"parameters":[{"code":15,"parameters":[3]}]},{"code":505,"indent":0,"parameters":[{"code":18}]},{"code":505,"indent":0,"parameters":[{"code":15,"parameters":[3]}]},{"code":123,"indent":0,"parameters":["A",0]},{"code":125,"indent":0,"parameters":[0,0,#{gold}]},{"code":101,"indent":0,"parameters":["",0,0,2]},{"code":401,"indent":0,"parameters":["#{gold}\\\\G 手に入れた！"]},{"code":0,"indent":0,"parameters":[]}],"moveFrequency":3,"moveRoute":{"list":[{"code":0,"parameters":[]}],"repeat":true,"skippable":false,"wait":false},"moveSpeed":3,"moveType":0,"priorityType":1,"stepAnime":false,"through":false,"trigger":0,"walkAnime":false},{"conditions":{"actorId":1,"actorValid":false,"itemId":1,"itemValid":false,"selfSwitchCh":"A","selfSwitchValid":true,"switch1Id":1,"switch1Valid":false,"switch2Id":1,"switch2Valid":false,"variableId":1,"variableValid":false,"variableValue":0},"directionFix":true,"image":{"characterIndex":0,"characterName":"!Chest","direction":8,"pattern":1,"tileId":0},"list":[{"code":0,"indent":0,"parameters":[]}],"moveFrequency":3,"moveRoute":{"list":[{"code":0,"parameters":[]}],"repeat":true,"skippable":false,"wait":false},"moveSpeed":3,"moveType":0,"priorityType":1,"stepAnime":false,"through":false,"trigger":0,"walkAnime":false}],"x":1,"y":1}
EV_DATA
