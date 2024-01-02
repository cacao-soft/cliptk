# 実行時のパスを取得する
p __exe__      # 実行ファイルのパス
p __file__     # スクリプトファイルのパス
p __dir__      # スクリプトフォルダのパス
p __project__  # プロジェクトファイルのパス (見つからない場合が nil)

# __project__ が "C:/dir/projects/game.proj" の場合
if __project__
  p File.dirname(__project__)         #=> "C:/dir/projects"
  p File.basename(__project__)        #=> "game.proj"
  p File.basename(__project__, false) #=> "game"
  p File.extname(__project__)         #=> ".proj"
end

# パスの区切り文字を変更
File::SEPARATOR = "\\"
p [__exe__, __file__, __dir__, __project__]

# フォルダと拡張子の削除
p File.basename("dir/file.tar.gz")              #=> "file.tar.gz"
p File.basename("dir/file.tar.gz", false)       #=> "file.tar"
p File.basename("dir/file.tar.gz", "*")         #=> "file"
p File.basename("dir/file.tar.gz", ".*")        #=> "file.tar"
p File.basename("dir/file.tar.gz", "gz")        #=> "file.tar"
p File.basename("dir/file.tar.gz", ".tar.gz")   #=> "file"
p File.basename("dir/file.m.rvdata2", "*data*") #=> "file.m"
