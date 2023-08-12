#
# マップデータの移植 MV -> VXAce
#

=begin
  data フォルダのマップデータをJSONからRVDATA2に変換する
=end

mv_info = load_data("data/MapInfos.json")
vxa_info = {}

Dir.glob("data/Map[0-9]*.json") do |path|
  map_id = path[/(\d+)/, 1].to_i
  mv_map = load_data(path)
  
  vxa_map = RPG::Map.new(mv_map["width"], mv_map["height"])
  vxa_map.tileset_id = mv_map["tilesetId"]

  data = mv_map["data"]
  max_tile_par_layer = vxa_map.width * vxa_map.height
  vxa_map.height.times do |y|
    vxa_map.width.times do |x|
      4.times do |z|
        n = data[max_tile_par_layer * z + y * vxa_map.width + x]
        vxa_map.data[x, y, [2,z].min] = n
      end
      vxa_map.data[x, y, 3] = data[max_tile_par_layer * 4 + y * vxa_map.width + x]
    end
  end
  
  events = mv_map["events"]
  events.each do |mv_event|
    next unless mv_event
    vxa_event = RPG::Event.new(mv_event["x"], mv_event["y"])
    vxa_event.id = mv_event["id"]
    vxa_map.events[vxa_event.id] = vxa_event
    vxa_event.pages = []
    mv_event["pages"].each do |mv_page|
      vxa_event.pages << RPG::Event::Page.new.tap do
        _1.graphic.tile_id = mv_page.dig("image", "tileId")
        _1.graphic.character_name = mv_page.dig("image", "characterName")
        _1.graphic.character_index = mv_page.dig("image", "characterIndex")
        _1.graphic.direction = mv_page.dig("image", "direction")
        _1.graphic.pattern = mv_page.dig("image", "pattern")
        _1.move_speed = mv_page["moveSpeed"]
        _1.move_frequency = mv_page["moveFrequency"]
        _1.walk_anime = mv_page["walkAnime"]
        _1.step_anime = mv_page["stepAnime"]
        _1.direction_fix = mv_page["directionFix"]
        _1.through = mv_page["through"]
        _1.priority_type = mv_page["priorityType"]
      end
    end
  end

  save_data(vxa_map, File.basename(path, false) + ".rvdata2")
  vxa_info[map_id] = RPG::MapInfo.new.tap do
    _1.name = mv_info.dig(map_id, "name")
    _1.parent_id = mv_info.dig(map_id, "parentId")
    _1.order = mv_info.dig(map_id, "order")
    _1.expanded = mv_info.dig(map_id, "expanded")
  end
  
  p [vxa_info[map_id].name, mv_map["width"], mv_map["height"], path]
end
save_data(vxa_info, "MapInfos.rvdata2")

vxa_tilesets = [nil]
load_data("data/Tilesets.json").each do |mv_tileset|
  next unless mv_tileset
  vxa_tileset = RPG::Tileset.new
  vxa_tileset.id = mv_tileset["id"]
  vxa_tileset.mode = mv_tileset["mode"]
  vxa_tileset.name = mv_tileset["name"]
  vxa_tileset.tileset_names = mv_tileset["tilesetNames"]
  vxa_tileset.note = mv_tileset["note"]
  mv_tileset["flags"].each_with_index do |flag,i|
    vxa_tileset.flags[i] = flag
  end
  vxa_tilesets << vxa_tileset
end
save_data(vxa_tilesets, "Tilesets.rvdata2")
