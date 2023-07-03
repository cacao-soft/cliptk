#
# タイルセットの未使用タイルを検索 for RPGツクールMV
#
if ARGV.empty?
  cmd = File.basename(__exe__, false)
  puts "Usage: #{cmd} #{__file__} Filename"
  puts " Filename  -> 拡張子は省略する"
  puts "", "Examples:", " #{cmd} #{__file__} Dungeon_B"
  exit
end
SEARCH_NAME = ARGV[0]

Dir.chdir(File.dirname(__project__))

def match_tile?(tileset_index, tile_id)
  case tile_id
  when 2048..2815 then tileset_index == 0
  when 2816..4351 then tileset_index == 1
  when 4352..5887 then tileset_index == 2
  when 5888..8191 then tileset_index == 3
  when 1536..1663 then tileset_index == 4
  else ;               tileset_index == tile_id / 256 + 5
  end
end

def tile_index_from(tile_id)
  case tile_id
  when 2048..2815 then (tile_id - 2048) / 48
  when 2816..4351 then (tile_id - 2816) / 48
  when 4352..5887 then (tile_id - 4352) / 48
  when 5888..8191 then (tile_id - 5888) / 48
  when 1536..1663 then (tile_id - 1536)
  else ;                tile_id % 256
  end
end

def tile_indexs_from(tileset_index, tile_id)
  return [] unless match_tile?(tileset_index, tile_id)
  tile_index = tile_index_from(tile_id)
  result = []  
  case tileset_index
  when 0
    if tile_index == 1
      tile_index = 2
    elsif tile_index == 2
      tile_index = 1
    end
    n = (tile_index % 2 == 0) ? 6 : 2
    offset = (tile_index % 2) * 6 + (tile_index / 8) * 48 + (tile_index % 4) / 2 * 24 + (tile_index / 4 % 2) * 128
    3.times {|y| n.times {|x| result << x + y * 8 + offset } }
  when 1
    offset = tile_index / 8 * 3 * 8 + tile_index % 4 * 2 + (tile_index / 4 % 2) * 128
    3.times {|y| 2.times {|x| result << offset + x + y * 8 } }
  when 2
    offset = tile_index / 8 * 2 * 8 + tile_index % 4 * 2 + (tile_index / 4 % 2) * 128
    2.times {|y| 2.times {|x| result << offset + x + y * 8 } }
  when 3
    offset = tile_index / 8 * 2 * 8 + tile_index % 4 * 2 + (tile_index / 4 % 2) * 128
    i = tile_index / 16
    n = (tile_index / 8 % 2 == 0) ? 3 : 2
    n.times {|y| 2.times {|x| result << offset + x + y * 8 } }
  else
    result << tile_index
  end
  result
end


used_tiles = Array.new(256)
mapinfos = JSON.read("data/MapInfos.json")
# タイルセットのどこで使用されているか
used_tilesets = {} # tileset_id => [tileset_index ...]
JSON.read("data/Tilesets.json").each do |tileset|
  next unless tileset
  tileset['tilesetNames'].each_with_index do |tilename,i|
    next if tilename != SEARCH_NAME
    (used_tilesets[tileset['id']] ||= []) << i
  end
end

map_list = []
mapdata_list = Dir.glob("data/Map[0-9]*.json")
mapdata_list.each do |filename|
  map_id = filename[/Map(\d+)/, 1].to_i
  print "\r#{map_id}/#{mapdata_list.size}"
  map = JSON.read(filename) rescue (next puts "\r[ERROR] #{'%03d'%map_id}: #{filename}")
  tileset_indexs = used_tilesets[map['tilesetId']]
  if tileset_indexs
    map_data = map['data'][0, map['width'] * map['height'] * 4].uniq
    tileset_indexs.each do |tileset_index|
      map_data.each do |tile_id|
        tile_indexs_from(tileset_index, tile_id).each { used_tiles[_1] = true }
      end
    end
  end
end

puts "\r==================================================================="

a, b = *used_tiles.map.with_index {|used,i| used ? "    " : " %3d"%i }.each_slice(128)
16.times do |y|
  puts "#{a[y * 8, 8].join} |#{b[y * 8, 8].join}"
end
