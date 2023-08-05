#
# マップデータの移植 MZ -> VXAce
#
#  MZマップをコピーした後にスクリプトを実行しVXAceに貼り付けます。
#  タイルの配置情報を簡易的に移植するだけのものです。
#  実際に使えるものにするには、タイルセットや影などの移植も必要だと思います。
#
mz_map, mz_info = Clipboard.data

vxa_map = RPG::Map.new(mz_map["width"], mz_map["height"])
vxa_map.tileset_id = mz_map["tilesetId"]
vxa_info = RPG::MapInfo.new
vxa_info.name = mz_info["name"]

mz_map_data = mz_map["data"]
max_tile_par_layer = vxa_map.width * vxa_map.height
4.times do |z|
  vxa_map.height.times do |y|
    vxa_map.width.times do |x|
      vxa_map.data[x, y, [z,2].min] =
        mz_map_data[max_tile_par_layer * z + y * vxa_map.width + x]
    end
  end
end

Clipboard << [vxa_map, vxa_info]
