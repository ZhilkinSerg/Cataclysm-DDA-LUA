require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

  id = "dda-lua-fun",
  version = "2017-08-12"

}

mods[MOD.id] = MOD

local NationalityMenu
local NationalityMenu_Title = "What is you nationality?"
local NationalityMenu_Entries = { --TODO: make local!

  -- menu_item_index = { nationality, bonus_quantity, bonus_items = { { "item_id", item_quantity, "optional container_id" } } }
 
  [0] = { "AMERICAN", 5, 
          {
            { "bat", 1 },
            { "american_flag", 1 },
            { "flag_shirt", 1 },
            { "bat_metal", 1 },
            { "mask_hockey", 1 },
            { "puck", 1 },
            { "hockey_stick", 1 },
            { "football_armor", 1 },
            { "helmet_football", 1 },
            { "football", 1 },
            { "basketball", 1 },
            { "hat_ball", 1 },
            { "helmet_ball", 1 },
            { "helmet_ball", 1 },
            { "baseball", 1 },
            { "pale_ale", 1, "bottle_glass" },
            { "hamburger", 1 }
          }
  },
  [1] = { "CANADIAN", 2,
          {
           { "syrup", 1, "bottle_glass"},
           { "mask_hockey", 1 },
           { "puck", 1 },
           { "hockey_stick", 1 },
           { "maple_candy", 1 }
          }
  },
  [2] = { "SCOTSMAN", 2,
          {
            { "scots_cookbook", 1 },
            { "whiskey", 1, "bottle_glass" },
            { "haggis", 1 },
            { "cloutie_dumpling", 1 },
            { "bagpipes", 1 },
            { "brew_whiskey", 1, "bottle_glass" },
            { "crossbow", 1 },
            { "cutlass", 1 },
            { "arming_sword", 1 },
            { "broadsword", 1 },
            { "battleaxe", 1 },
            { "estoc", 1 },
            { "longsword", 1 },
            { "zweihander", 1 },
            { "kilt", 1 }
          }
  },
  [3] = { "RUSSIAN", 2,
          {
           { "mask_hockey", 1 },
           { "puck", 1 },
           { "hockey_stick", 1 },
           { "moonshine", 1 },
           { "shovel", 1 },
           { "milk", 1, "bottle_plastic"},
           { "vodka", 1, "bottle_glass" }
          }
  },
  [4] = { "MEXICAN", 2,
          {
            { "nachos" , 1 },
            { "nachosc" , 1 },
            { "nachosm" , 1 },
            { "nachosmc" , 1 },
            { "tortilla_corn" , 1 },
            { "cornbread" , 1 },
            { "quesadilla_cheese" , 1 },
            { "tequila" , 1, "bottle_glass" },
            { "hat_sombrero" , 1 },
            { "poncho" , 1 }
          }
  },
  [5] = { "FRENCH", 2,
          {
            { "frenchtoast" , 1 },
            { "cheese_hard" , 1 },
            { "wine_riesling" , 1, "bottle_glass" },
            { "wine_chardonnay" , 1, "bottle_glass" },
            { "wine_cabernet" , 1, "bottle_glass" },
            { "wine_noir" , 1, "bottle_glass" }
          }
  },
  [6] = { "JAPANESE", 2, 
  {
          { "textbook_armeast", 1 },
          { "tanto", 1 },
          { "katana", 1 },
          { "katana_fake", 1 },
          { "firekatana_off", 1 },
          { "helmet_kabuto", 1 },
          { "armor_samurai", 1 },
          { "sushi_rice", 1 },
          { "sushi_veggyroll", 1 },
          { "sushi_fishroll", 1 },
          { "sushi_meatroll", 1 },
          { "sushi_rice", 1 }
  }
  },
  [7] = { "ZULU", 2, 
          {
            { "meat", 1 },
            { "meat_cooked", 1 },
            { "meat_smoked", 1 },
            { "jerky", 1 },
            { "spear_wood", 1 }
          }
  }

}

function Create_NationalityMenu()

  NationalityMenu = game.create_uimenu()
  NationalityMenu.title = NationalityMenu_Title
  
  for k,v in pairs(NationalityMenu_Entries) do

    local nationality = v[1]
    local bonus_quantity = v[2]
    local bonus_items = v[3]
    NationalityMenu:addentry("I am <color_white>"..nationality.."</color>. I will receive <color_green>"..bonus_quantity.."</color> of <color_green>"..#bonus_items.."</color> bonus items!")

  end

end

function Show_NationalityMenu()

  Create_NationalityMenu()

  NationalityMenu:show()
  NationalityMenu:query(true)

  local choice = NationalityMenu.selected -- TODO: menu items are numbered from 0, lua-tables are numbered from 1 by default
  
  return choice

end

function MOD.on_game_loaded() 

  LOG.message(MOD.id..".main.on_game_loaded:START")

  --LOG.message ("You can use `game` global, but cannot use `player` global here.")
  --LOG.message ("This is run before character selection screen is loaded right after `preload.lua` is executed.")
  
  LOG.message(MOD.id..".main.on_game_loaded:END")

end

function MOD.on_new_player_created()

  LOG.message(MOD.id..".main.on_new_player_created:START")

  --LOG.message ("You can use both `game` and `player` globals here.")
  --LOG.message ("This is run once when new game is started and player character is created.")
  --LOG.message ("This is good place for calling MOD.Init() function.")

  MOD.Init()

  LOG.message(MOD.id..".main.on_new_player_created:END")

end

function MOD.on_skill_increased()

  LOG.message(MOD.id..".main.on_skill_increased:START")

  --LOG.message ("You can use both `game` and `player` globals here.")
  --LOG.message ("This is run player character skill level increases.")
  --LOG.message ("This is good place for calling MOD.Update() function.")

  MOD.Update()

  LOG.message(MOD.id..".main.on_skill_increased:END")

end

function MOD.on_minute_passed()

  LOG.message(MOD.id..".main.on_minute_passed:START")

  --LOG.message ("You can use both `game` and `player` globals here.")
  --LOG.message ("This is run once per minute.")
  --LOG.message ("This is good place for calling MOD.Update() function.")

  MOD.Update()

  LOG.message(MOD.id..".main.on_minute_passed:END")

end

function MOD.on_day_passed()

  LOG.message(MOD.id..".main.on_day_passed:START")

  --LOG.message ("You can use both `game` and `player` globals here.")
  --LOG.message ("This is run once per minute.")
  --LOG.message ("This is good place for calling MOD.Update() function.")

  MOD.Update()

  LOG.message(MOD.id..".main.on_day_passed:END")

end

MOD.Init = function()

  LOG.message(MOD.id..".main.Init:START")

  --LOG.message ("Initialization logic goes here.")

  local nationality_id = Show_NationalityMenu()
  --DisplayMessage("nationality_id:"..nationality_id)
  
  local nationality_record = NationalityMenu_Entries[nationality_id]
  --DisplayMessage("nationality_record:"..tostring(nationality_record))

  local nationality = nationality_record[1]
  --DisplayMessage("nationality:"..tostring(nationality))

  local bonus_quantity = nationality_record[2]
  --DisplayMessage("bonus_quantity:"..tostring(bonus_quantity))

  local bonus_items = nationality_record[3]
  --DisplayMessage("#bonus_items:"..tostring(#bonus_items))


  for _= 1, bonus_quantity  do

    local bonus = table.random_value(bonus_items)
    local item_id = bonus[1]
    local item_quantity = bonus[2]
    local container_id = bonus[3]

    --DisplayMessage("item_id:"..tostring(item_id))
    --DisplayMessage("item_quantity:"..tostring(item_quantity))
    --DisplayMessage("container_id:"..tostring(container_id))
   
    AddItemToPlayerInventoryGeneric(item_id, item_quantity, container_id)

  end
  
  --[[
  for _,bonus in pairs(bonus_items) do

   local item_id = bonus[1]
   local item_quantity = bonus[2]
   local container_id = bonus[3]

   DisplayMessage("item_id:"..tostring(item_id))
   DisplayMessage("item_quantity:"..tostring(item_quantity))
   DisplayMessage("container_id:"..tostring(container_id))
   
   AddItemToPlayerInventoryGeneric(item_id, item_quantity, container_id)

  end
  ]]

  LOG.message(MOD.id..".main.Init:END")

end

MOD.Update = function()

  LOG.message(MOD.id..".main.Update:START")

  --LOG.message ("Update logic goes here.")

  LOG.message(MOD.id..".main.Update:END")

end

MOD.on_game_loaded()
