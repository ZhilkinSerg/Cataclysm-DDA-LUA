require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

 id = "dda-lua-items"

}

local EntityScanner_ToolName = "Entity Scanner v. 1.00"

local EntityScanner_MenuMain
local EntityScanner_MenuOptions
local EntityScanner_MenuScanItem
local EntityScanner_MenuScanMonster
local EntityScanner_MenuMainEntries
local EntityScanner_MenuOptionsEntries
local EntityScanner_MenuScanItemEntries
local EntityScanner_MenuScanMonsterEntries

local EntityScanner_Options = {

  ["SearchMask"] = { [0] = nil, [1] = ".*" },
  ["ScanRadius"] = { [0] = nil, [1] = REALITY_BUBBLE_WIDTH / 2 },
  ["Highlight"] = { [0] = nil, [1] = "fd_laser" },
  ["GUIFieldLength"] = { [0] = nil, [1] = 15 }

}

local EarthquakeGenerator_ToolName = "Earthquake Generator v. 1.00"

local EarthquakeGenerator_MenuMain
local EarthquakeGenerator_MenuOptions
local EarthquakeGenerator_MenuMainEntries = {}
local EarthquakeGenerator_MenuOptionsEntries= {}

local EarthquakeGenerator_Options = {

  ["QuakeRange"] = { [0] = nil, [1] = REALITY_BUBBLE_WIDTH / 12 },
  ["GUIFieldLength"] = { [0] = nil, [1] = 15 }

}

function Create_EntityScanner_MenuMain()

  EntityScanner_MenuMainEntries = {
    [0] = "Switch off",
    [1] = "Options",
    [2] = "Scan surroundings for items",
    [3] = "Scan surroundings for monsters"
  }

  EntityScanner_MenuMain = game.create_uimenu()
  EntityScanner_MenuMain.title = EntityScanner_ToolName.." : MAIN MENU"
  EntityScanner_MenuMain:addentry("Switch off")
  EntityScanner_MenuMain:addentry("Options")
  EntityScanner_MenuMain:addentry("Scan surroundings for items")
  EntityScanner_MenuMain:addentry("Scan surroundings for monsters")

end

function Create_EntityScanner_MenuOptions()

  EntityScanner_MenuOptionsEntries = {
    [0] = "Back to main menu",
    [1] = "Reset all options to default"
  }

  EntityScanner_MenuOptions = game.create_uimenu()
  EntityScanner_MenuOptions.title = EntityScanner_ToolName.." : OPTIONS"
  EntityScanner_MenuOptions:addentry("Back to main menu")
  EntityScanner_MenuOptions:addentry("<color_ltred>Reset all options to default</color>")
  for k,v in spairs_reverse(EntityScanner_Options) do
    EntityScanner_MenuOptions:addentry("Change option: <color_green>"..k.."</color> = <color_ltgreen>"..v[0].."</color>")
    EntityScanner_MenuOptionsEntries [#EntityScanner_MenuOptionsEntries+1] = k
  end

end

function Create_EntityScanner_MenuScanItem()

  EntityScanner_MenuScanItemEntries = {
    [0] = { [0] = "Back to main menu", [1] = nil, [2] = nil, [3] = nil },
    [1] = { [0] = "Highlight all items", [1] = nil, [2] = nil, [3] = nil }
  }

  EntityScanner_MenuScanItem = game.create_uimenu()
  EntityScanner_MenuScanItem.title = EntityScanner_ToolName.." : SCAN MENU - ITEM MODE"
  EntityScanner_MenuScanItem:addentry("Back to main menu")
  EntityScanner_MenuScanItem:addentry("<color_ltgreen>Highlight all items</color>")

end

function Create_EntityScanner_MenuScanMonster()

  EntityScanner_MenuScanMonsterEntries = {
    [0] = { [0] = "Back to main menu", [1] = nil, [2] = nil, [3] = nil },
    [1] = { [0] = "Highlight all monsters", [1] = nil, [2] = nil, [3] = nil }
  }

  EntityScanner_MenuScanMonster = game.create_uimenu()
  EntityScanner_MenuScanMonster.title = EntityScanner_ToolName.." : SCAN MENU - MONSTER MODE"
  EntityScanner_MenuScanMonster:addentry("Back to main menu")
  EntityScanner_MenuScanMonster:addentry("<color_ltgreen>Highlight all monsters</color>")

end

function Show_EntityScanner_MenuMain()

  Create_EntityScanner_MenuMain()

  EntityScanner_MenuMain:show()
  EntityScanner_MenuMain:query(true)

  local choice = EntityScanner_MenuMain.selected

  if (choice == 0) then
    display.message ("You switch off your scanner and put it back.")
  elseif (choice == 1) then
    Show_EntityScanner_MenuOptions()
  elseif (choice == 2) then
    Show_EntityScanner_MenuScanItem()
  elseif (choice == 3) then
    Show_EntityScanner_MenuScanMonster()
  end

end

function Show_EntityScanner_MenuOptions()

  Create_EntityScanner_MenuOptions()

  EntityScanner_MenuOptions:show()
  EntityScanner_MenuOptions:query(true)

  local choice = EntityScanner_MenuOptions.selected

  if (choice == 0) then
    Show_EntityScanner_MenuMain()
  elseif (choice == 1) then
    Reset_EntityScanner_Options()
  else
    Edit_EntityScanner_Option(EntityScanner_MenuOptionsEntries[choice])
  end

end

function Show_EntityScanner_MenuScanItem()

  display.message("<color_green>Started scanning for items...</color>")

  Create_EntityScanner_MenuScanItem()

  local ScanRadius = GetValue_EntityScannerOptions("ScanRadius", true)

  local center = player:pos()

  for x = -ScanRadius, ScanRadius do
    for y = -ScanRadius, ScanRadius do
      local z = 0 --only current Z-level

      local point = tripoint (center.x + x, center.y + y, center.z + z)
      local distance = game.trig_dist(point.x, point.y, center.x, center.y)

      if (distance <= ScanRadius) then
        if map:i_at(point):size() > 0 then
          local item_stack_iterator =  map:i_at(point):cppbegin()
          for _ = 1, map:i_at(point):size() do
            AddEntry_EntityScanner_MenuScanItem(item_stack_iterator:elem(), point.x, point.y, point.z)
            item_stack_iterator:inc()
          end
        end
      end

    end
  end

  EntityScanner_MenuScanItem:show()
  EntityScanner_MenuScanItem:query(true)

  local choice = EntityScanner_MenuScanItem.selected

  display.message("<color_green>Finished scanning for items...</color>")

  if choice == 0 then
    display.message ("You decided not to highlight items...")
    Show_EntityScanner_MenuMain()
  elseif choice == 1 then
    display.message ("You decided to highlight all items...")
    EntityScanner_HighlightAllEntities(EntityScanner_MenuScanItemEntries)
  else
    display.message ("You decided to highlight single item...")
    EntityScanner_HighlightSingleEntity (choice, EntityScanner_MenuScanItemEntries)
  end

end

function Show_EntityScanner_MenuScanMonster()

  display.message("<color_green>Started scanning for monsters...</color>")

  Create_EntityScanner_MenuScanMonster()

  local ScanRadius = GetValue_EntityScannerOptions("ScanRadius", true)

  local center = player:pos()

  local n_max = g:num_zombies()
  for n = 0, (n_max - 1) do
    local monster = g:zombie(n)
    local point = monster:pos()
    local distance = game.trig_dist(point.x, point.y, center.x, center.y)

    if (distance <= ScanRadius) then
      AddEntry_EntityScanner_MenuScanMonster(monster, point.x, point.y, point.z)
    end
  end

  EntityScanner_MenuScanMonster:show()
  EntityScanner_MenuScanMonster:query(true)

  local choice = EntityScanner_MenuScanMonster.selected

  display.message("<color_green>Finished scanning for monsters...</color>")

  if choice == 0 then
    display.message ("You decided not to highlight monsters...")
    Show_EntityScanner_MenuMain()
  elseif choice == 1 then
    display.message ("You decided to highlight all monsters...")
    EntityScanner_HighlightAllEntities(EntityScanner_MenuScanMonsterEntries)
  else
    display.message ("You decided to highlight single monster...")
    EntityScanner_HighlightSingleEntity (choice, EntityScanner_MenuScanMonsterEntries)
  end

end

function GetValue_EntityScannerOptions(k, isnumber)

  local v = tostring(EntityScanner_Options[k][0])

  if (isnumber ~= nil and isnumber == true) then
    return tonumber(v)
  else
    return v
  end

end

function Check_EntityScanner_Options()

  for _,v in spairs_reverse(EntityScanner_Options) do
    if (v[0] == "nil" or v[0] == "") then
      v[0] = tostring(v[1])
    end
  end

end

function Reset_EntityScanner_Options()

  for _,v in spairs_reverse(EntityScanner_Options) do
    v[0] = tostring(v[1])
  end

  game.popup ("<color_red>All options were reset to default.</color>")

  Show_EntityScanner_MenuOptions()

end

function Load_EntityScanner_Options()

  for k,v in spairs_reverse(EntityScanner_Options) do
    local v_new = player:get_value(k)
    v[0] = tostring(v_new)
  end

  Check_EntityScanner_Options()

end

function Save_EntityScanner_Options()

  Check_EntityScanner_Options()

  for k,v in spairs_reverse(EntityScanner_Options) do
    player:set_value(k, tostring(v[0]))
  end

end

function Edit_EntityScanner_Option(k)

  local v = tostring(EntityScanner_Options[k][0])
  --local d = tostring(EntityScanner_Options[k][1])

  EntityScanner_Options[k][0] = game.string_input_popup ("New "..k.." value is:", GetValue_EntityScannerOptions("GUIFieldLength", true), "Old "..k.." value is: "..v.."")

  Save_EntityScanner_Options()
  Show_EntityScanner_MenuOptions()

end

function AddEntry_EntityScanner_MenuScanItem(entity, x, y, z)

  local item = entity

  if (string.match(item:display_name(), GetValue_EntityScannerOptions("SearchMask")) ~= nil) then

    EntityScanner_MenuScanItemEntries [#EntityScanner_MenuScanItemEntries+1] = { [0] = item:display_name(), [1] = x, [2] = y, [3] = z }

    local menu_entry = string.format("Item: %s [W:<color_white>%d</color>, V:<color_white>%d</color>] at [X:<color_white>%d</color>, Y:<color_white>%d</color>, Z:<color_white>%d</color>]", item:display_name(), item.type.weight, item.type.volume:value(), x, y, z)
    EntityScanner_MenuScanItem:addentry(menu_entry)

  end

end

function AddEntry_EntityScanner_MenuScanMonster(entity, x, y, z)

  local monster = entity

  if (string.match(monster:disp_name(), GetValue_EntityScannerOptions("SearchMask")) ~= nil) then

    EntityScanner_MenuScanMonsterEntries [#EntityScanner_MenuScanMonsterEntries+1] = { [0] = monster:disp_name(), [1] = x, [2] = y, [3] = z }

    local menu_entry = string.format("Monster: %s at [X:<color_white>%d</color>, Y:<color_white>%d</color>, Z:<color_white>%d</color>]", monster:disp_name(), x, y, z)
    EntityScanner_MenuScanMonster:addentry(menu_entry)

  end

end

function EntityScanner_HighlightSingleEntity (choice, collection)

  local x1 = player:pos().x
  local y1 = player:pos().y
  --local z1 = player:pos().z

  local x2 = collection[choice][1]
  local y2 = collection[choice][2]
  --local z2 = collection[choice][3]

  DISPLAY.line_field (x1, y1, x2, y2, GetValue_EntityScannerOptions("Highlight")) --only current Z-level
  DISPLAY.line_field (x1, y1, x2, y2, GetValue_EntityScannerOptions("Highlight")) --only current Z-level

end

function EntityScanner_HighlightAllEntities(collection)

  local num_filter_items = 2 --TODO: make dynamic or check that entry is table in EntityScanner_HighlightSingleEntity?
  if (#collection > num_filter_items) then
    for i = num_filter_items + 1, #collection do
      --display.message("i:"..i)
      EntityScanner_HighlightSingleEntity(i, collection)
    end
  else
    display.message ("<color_ltred>Nothing to highlight!</color>")
  end

end

function Create_EarthquakeGenerator_MenuMain()

  EarthquakeGenerator_MenuMainEntries = {
    [0] = "Switch off",
    [1] = "Options",
    [2] = "Start Earthquake"
  }

  EarthquakeGenerator_MenuMain = game.create_uimenu()
  EarthquakeGenerator_MenuMain.title = EarthquakeGenerator_ToolName.." : MAIN MENU"
  EarthquakeGenerator_MenuMain:addentry("Switch off")
  EarthquakeGenerator_MenuMain:addentry("Options")
  EarthquakeGenerator_MenuMain:addentry("Start Earthquake")

end

function Create_EarthquakeGenerator_MenuOptions()

  EarthquakeGenerator_MenuOptionsEntries = {
    [0] = "Back to main menu",
    [1] = "Reset all options to default"
  }

  EarthquakeGenerator_MenuOptions = game.create_uimenu()
  EarthquakeGenerator_MenuOptions.title = EarthquakeGenerator_ToolName.." : OPTIONS"
  EarthquakeGenerator_MenuOptions:addentry("Back to main menu")
  EarthquakeGenerator_MenuOptions:addentry("<color_ltred>Reset all options to default</color>")
  for k,v in spairs_reverse(EarthquakeGenerator_Options) do
    EarthquakeGenerator_MenuOptions:addentry("Change option: <color_green>"..k.."</color> = <color_ltgreen>"..v[0].."</color>")
    EarthquakeGenerator_MenuOptionsEntries [#EarthquakeGenerator_MenuOptionsEntries+1] = k
  end

end

function Show_EarthquakeGenerator_MenuMain()

  Create_EarthquakeGenerator_MenuMain()

  EarthquakeGenerator_MenuMain:show()
  EarthquakeGenerator_MenuMain:query(true)

  local choice = EarthquakeGenerator_MenuMain.selected

  if (choice == 0) then
    display.message ("You switch off your earthquake generator and put it back.")
  elseif (choice == 1) then
    Show_EarthquakeGenerator_MenuOptions()
  elseif (choice == 2) then
    StartQuake()
  end

end

function Show_EarthquakeGenerator_MenuOptions()

  Create_EarthquakeGenerator_MenuOptions()

  EarthquakeGenerator_MenuOptions:show()
  EarthquakeGenerator_MenuOptions:query(true)

  local choice = EarthquakeGenerator_MenuOptions.selected

  if (choice == 0) then
    Show_EarthquakeGenerator_MenuMain()
  elseif (choice == 1) then
    Reset_EarthquakeGenerator_Options()
  else
    Edit_EarthquakeGenerator_Option(EarthquakeGenerator_MenuOptionsEntries[choice])
  end

end

function GetValue_EarthquakeGeneratorOptions(k, isnumber)

  local v = tostring(EarthquakeGenerator_Options[k][0])

  if (isnumber ~= nil and isnumber == true) then
    return tonumber(v)
  else
    return v
  end

end

function Check_EarthquakeGenerator_Options()

  for _,v in spairs_reverse(EarthquakeGenerator_Options) do
    if (v[0] == "nil" or v[0] == "") then
      v[0] = tostring(v[1])
    end
  end

end

function Reset_EarthquakeGenerator_Options()

  for _,v in spairs_reverse(EarthquakeGenerator_Options) do
    v[0] = tostring(v[1])
  end

  game.popup ("<color_red>All options were reset to default.</color>")

  Show_EarthquakeGenerator_MenuOptions()

end

function Load_EarthquakeGenerator_Options()

  for k,v in spairs_reverse(EarthquakeGenerator_Options) do
    local v_new = player:get_value(k)
    v[0] = tostring(v_new)
  end

  Check_EarthquakeGenerator_Options()

end

function Save_EarthquakeGenerator_Options()

  Check_EarthquakeGenerator_Options()

  for k,v in spairs_reverse(EarthquakeGenerator_Options) do
    player:set_value(k, tostring(v[0]))
  end

end

function Edit_EarthquakeGenerator_Option(k)

  local v = tostring(EarthquakeGenerator_Options[k][0])
  --local d = tostring(EarthquakeGenerator_Options[k][1])

  EarthquakeGenerator_Options[k][0] = game.string_input_popup ("New "..k.." value is:", GetValue_EarthquakeGeneratorOptions("GUIFieldLength", true), "Old "..k.." value is: "..v.."")

  Save_EarthquakeGenerator_Options()
  Show_EarthquakeGenerator_MenuOptions()

end

function StartQuake()

  display.message("<color_red>Artificial earthquake started!</color>")

  local QuakeRange = GetValue_EarthquakeGeneratorOptions ("QuakeRange", true)

  local center = player:pos()

  for x = -QuakeRange, QuakeRange do
    for y = -QuakeRange, QuakeRange do
      local z = 0 --only current Z-level

      local point = tripoint (center.x + x, center.y + y, center.z + z)
      local distance = game.trig_dist(point.x, point.y, center.x, center.y)

      if (distance <= QuakeRange) then

        --TODO: Rework these three ugly `if-else`!
        --TODO: Maybe affect monsters?

        --terrain(dirt, etc)
        if game.one_in(2) then
          --nothing
        elseif game.one_in(5) then
          map:ter_set(point, ter_str_id("t_dirt"))
        elseif game.one_in(5) then
          map:ter_set(point, ter_str_id("t_dirtmound"))
        elseif game.one_in(5) then
          map:ter_set(point, ter_str_id("t_pitshallow"))
        elseif game.one_in(10) then
          map:ter_set(point, ter_str_id("t_pit"))
        elseif game.one_in(5) then
          map:ter_set(point, ter_str_id("t_sand"))
        elseif game.one_in(5) then
          --map:ter_set(point, ter_str_id("t_lava"))
        end

        --furniture (rubble, etc)
        if game.one_in(2) then
          --nothing
        elseif game.one_in(3) then
          map:furn_set(point, furn_str_id("f_rubble_rock"))
        elseif game.one_in(3) then
          map:furn_set(point, furn_str_id("f_wreckage"))
        elseif game.one_in(3) then
          map:furn_set(point, furn_str_id("f_rubble"))
        end

        --fields (dust, etc)
        if game.one_in(2) then
          --nothing
        elseif game.one_in(5) then
          map:add_field(point, "fd_smoke", 2, 0)
        elseif game.one_in(20) then
          --map:add_field(point, "fd_fire", 2, 0)
        end

      end

    end
  end

  display.message("<color_red>Artificial earthquake ended.</color>")

end

function iuse_dda_lua_item_entity_scanner(item, active)

  Load_EntityScanner_Options()
  Show_EntityScanner_MenuMain()
  Save_EntityScanner_Options()

end

function iuse_dda_lua_item_earthquake_generator(item, active)

  Load_EarthquakeGenerator_Options()
  Show_EarthquakeGenerator_MenuMain()
  Save_EarthquakeGenerator_Options()
  
end

function iuse_dda_lua_item(item, active)

  local item_name = tostring(item:display_name())

  --display.message("<color_white>Using item <color_cyan>"..item_name.."</color> in iuse_dda_lua_item function</color>")
  
  --display.message(item:info())

  if (item_name == "atomic entity scanner") then

    iuse_dda_lua_item_entity_scanner(item, active)

  elseif (item_name == "atomic earthquake generator") then

    iuse_dda_lua_item_earthquake_generator(item, active)

  else

    display.message("<color_red>Unknown item in iuse_dda_lua_item function!</color>")

  end

end

function plot_field (x, y, fd)

  map:add_field(tripoint(x,y,player:pos().z), fd, 1, 0)
  
end

function line_field (x1, y1, x2, y2, fd)

  local delta_x = x2 - x1
  local ix = delta_x > 0 and 1 or -1
  delta_x = 2 * math.abs(delta_x)

  local delta_y = y2 - y1
  local iy = delta_y > 0 and 1 or -1
  delta_y = 2 * math.abs(delta_y)

  plot_field(x1, y1, fd)

  if delta_x >= delta_y then
    error = delta_y - delta_x / 2

    while x1 ~= x2 do
      if (error >= 0) and ((error ~= 0) or (ix > 0)) then
        error = error - delta_x
        y1 = y1 + iy
      end

      error = error + delta_y
      x1 = x1 + ix

      plot_field(x1, y1, fd)
    end
  else
    error = delta_x - delta_y / 2

    while y1 ~= y2 do
      if (error >= 0) and ((error ~= 0) or (iy > 0)) then
        error = error - delta_y
        x1 = x1 + ix
      end

      error = error + delta_x
      y1 = y1 + iy

      plot_field(x1, y1, fd)
    end
  end
end

function get_directions(p1, p2)

	return (p2.x-p1.x), (p2.y-p1.y)

end

function flamethrower(item, active) --Adjacent direction

	local burst_cone_min_length = 0
	local burst_cone_max_length = 12
	local burst_cone_width = math.random(3, 12)

	--game.add_msg(tostring(burst_cone_width))

	local burst_field = "fd_fire"

    local center = player:pos()
    local selected_x, selected_y = game.choose_adjacent("Select direction to <color_red>burn</color>", center.x, center.y)
    local selected_point = tripoint(selected_x, selected_y, center.z)
	local selected_direction_x,selected_direction_y = get_directions(center, selected_point)

	local start_point = tripoint(selected_point.x + selected_direction_x * burst_cone_min_length, selected_point.y + selected_direction_y * burst_cone_min_length, selected_point.z)
	local end_point = tripoint(selected_point.x + selected_direction_x * burst_cone_max_length, selected_point.y + selected_direction_y * burst_cone_max_length, selected_point.z)

	for w = -burst_cone_width/2, burst_cone_width/2 do
		local temp_end_point1 = tripoint(end_point.x + w, end_point.y + w, end_point.z)
		local temp_end_point2 = tripoint(end_point.x + w, end_point.y + selected_direction_y * w, end_point.z)
		local temp_end_point3 = tripoint(end_point.x + selected_direction_x * w, end_point.y + w, end_point.z)
		local temp_end_point4 = tripoint(end_point.x + selected_direction_x * w, end_point.y + selected_direction_y * w, end_point.z)
		line_field(start_point.x, start_point.y, temp_end_point1.x, temp_end_point1.y, burst_field)
		line_field(start_point.x, start_point.y, temp_end_point2.x, temp_end_point2.y, burst_field)
		line_field(start_point.x, start_point.y, temp_end_point3.x, temp_end_point3.y, burst_field)
		line_field(start_point.x, start_point.y, temp_end_point4.x, temp_end_point4.y, burst_field)
	end

	--game.add_msg("<color_red>BURN!!!</color>")

end

function on_preload()

  LOG.message(MOD.id..".preload.on_preload:START")

  game.register_iuse("IUSE_DDA_LUA_ENTITY_SCANNER", iuse_dda_lua_item)
  game.register_iuse("IUSE_DDA_LUA_EARTHQUAKE_GENERATOR", iuse_dda_lua_item)
  
  --game.register_iuse("IUSE_DDA_LUA_ENTITY_SCANNER", iuse_dda_lua_item_entity_scanner)
  --game.register_iuse("IUSE_DDA_LUA_EARTHQUAKE_GENERATOR", iuse_dda_lua_item_earthquake_generator)
  
  game.register_iuse("IUSE_DDA_LUA_FLAMETHROWER", flamethrower)

  LOG.message(MOD.id..".preload.on_preload:END")

end

on_preload()