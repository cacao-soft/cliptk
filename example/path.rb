# 実行時のパスを取得する
p __exe__      # 実行ファイルのパス
p __file__     # スクリプトファイルのパス
p __dir__      # スクリプトフォルダのパス
p __project__  # プロジェクトファイルのパス


# __project__ が "C:/dir/projects/game.proj2" の場合
p File.dirname(__project__)         #=> "C:/dir/projects"
p File.basename(__project__)        #=> "game.proj2"
p File.basename(__project__, false) #=> "game"
p File.extname(__project__)         #=> ".proj2"
