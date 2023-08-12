# RPGツクールXP,VX,VXAceのデータの読み書き
event = load_data("宝箱VXA.rvdata2")
save_data(event, "宝箱VXA2.rvdata2")

# RPGツクールMV,MZのデータの読み書き
# ファイルの拡張子が json の場合は JSON として読み書きします
save_data({"test" => 123}, "test.json")
p load_data("test.json")

# カレントディレクトリの rb ファイルを列挙する
Dir.glob("*.rb") do |filename|
  puts filename
end

# プロジェクトがあればデータフォルダ内の rvdata2 ファイルを列挙する
if __project__
  search_pattern = File.join(File.dirname(__project__), "Data/*.rvdata2")
  puts Dir.glob(search_pattern)
end
