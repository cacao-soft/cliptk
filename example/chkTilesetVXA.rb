#
# タイルの使用マップを検索 for RPGツクールVXAce
#
if ARGV.size != 2
  cmd = File.basename(__exe__).split(".").tap(&:pop).join
  puts "Usage: #{cmd} #{__file__} Filename TileIndex"
  puts " Filename  -> 拡張子は省略する"
  puts " TileIndex -> A1(0-15), A2-3(0-31), A4(0-23), A5(0-127), B-E(0-255)"
  puts "", "Examples:", " #{cmd} #{__file__} Dungeon_B 250"
  exit
end

SEARCH_NAME = ARGV[0]
SEARCH_INDEX = ARGV[1].to_i

mapinfos = load_data("Data/MapInfos.rvdata2")
tileset_id_list = {}
load_data("Data/Tilesets.rvdata2").each do |tileset|
  next unless tileset
  tileset.tileset_names.each_with_index do |tilename,i|
    next if tilename != SEARCH_NAME
    next if SEARCH_INDEX == 0 && i == 5
    (tileset_id_list[tileset.id] ||= []) << case i
    when 0 then (SEARCH_INDEX * 48 + 2048)...(SEARCH_INDEX * 48 + 2096)
    when 1 then (SEARCH_INDEX * 48 + 2816)...(SEARCH_INDEX * 48 + 2864)
    when 2 then (SEARCH_INDEX * 48 + 4352)...(SEARCH_INDEX * 48 + 4400)
    when 3 then (SEARCH_INDEX * 48 + 5888)...(SEARCH_INDEX * 48 + 5936)
    when 4 then SEARCH_INDEX + 1536
    else;       SEARCH_INDEX + (i - 5) * 256
    end
  end
end

map_list = []
mapdata_list = Dir.glob("Data/Map[0-9]*.rvdata2")
mapdata_list.each do |filename|
  map_id = filename[/Map(\d+)/, 1].to_i
  print "\r#{map_id}/#{mapdata_list.size}"
  map = load_data(filename) rescue (next puts "\r[ERROR] #{'%03d'%map_id}: #{filename}")
  if tileset_id_list[map.tileset_id]
    (map.width * map.height * 3).times do |i|
      x, y, z = (i / 3) % map.width, i / (map.width * 3), i % 3
      included = false
      tileset_id_list[map.tileset_id].each do |tile_id|
        if tile_id === map.data[x, y, z]
          included = true
          a = []
          parent_id = mapinfos[map_id].parent_id
          while parent_id != 0
            a << sprintf("%03d:%s", parent_id, mapinfos[parent_id].name)
            parent_id = mapinfos[parent_id].parent_id
          end
          a.reverse!
          a = [a[0], a[1], "...", a[-1]] if a.size > 3
          map_list << sprintf("%03d: %s [%s]", map_id, mapinfos[map_id].name, a.join("->"))
          break
        end
      end
      break if included
    end
  end
end

puts "\r===================="
puts map_list
