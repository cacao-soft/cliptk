#
# [MZ] 宝箱イベントの編集
#

# イベントの簡単作成で宝箱を作りクリップボードへコピーする
# このスクリプトを実行すると修正されるのでマップへペーストする。

# クリップボードのデータを取得する
clipdata = Clipboard.data

# mv と mz は文字列
if clipdata.is_a?(String)
  # JSON から Ruby オブジェクトに変換
  obj = JSON.parse(clipdata)
  # 内容を修正する
  if obj["name"]&.start_with?("宝箱")
    obj.dig("pages", 0, "list").each do |command|
      next if command["code"] != 125    # 所持金の増減以外なら次へ
      command["parameters"][2] = 1234   # オペランドを変更
    end
  end
end

# JSON 文字列に戻してクリップボードに設定
Clipboard << JSON.generate(obj)
