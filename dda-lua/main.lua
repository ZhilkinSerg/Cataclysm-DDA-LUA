require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

  id = "dda-lua",
  version = "2017-08-13"

}

mods[MOD.id] = MOD

function MOD.on_game_loaded() 

  LOG.message(MOD.id..".main.on_game_loaded:START")

  LOG.message ("You can use `game` global, but cannot use `player` global here.")
  LOG.message ("This is run before character selection screen is loaded right after `preload.lua` is executed.")

  LOG.message(MOD.id..".main.on_game_loaded:END")

end

function MOD.on_new_player_created()

  LOG.message(MOD.id..".main.on_new_player_created:START")

  LOG.message ("You can use both `game` and `player` globals here.")
  LOG.message ("This is run once when new game is started and player character is created.")
  LOG.message ("This is good place for calling MOD.Init() function.")

  MOD.Init()

  LOG.message(MOD.id..".main.on_new_player_created:END")

end

function MOD.on_skill_increased()

  LOG.message(MOD.id..".main.on_skill_increased:START")

  LOG.message ("You can use both `game` and `player` globals here.")
  LOG.message ("This is run player character skill level increases.")
  LOG.message ("This is good place for calling MOD.Update() function.")

  MOD.Update()

  LOG.message(MOD.id..".main.on_skill_increased:END")

end

function MOD.on_minute_passed()

  LOG.message(MOD.id..".main.on_minute_passed:START")

  LOG.message ("You can use both `game` and `player` globals here.")
  LOG.message ("This is run once per minute.")
  LOG.message ("This is good place for calling MOD.Update() function.")

  MOD.Update()

  LOG.message(MOD.id..".main.on_minute_passed:END")

end

function MOD.on_day_passed()

  LOG.message(MOD.id..".main.on_day_passed:START")

  LOG.message ("You can use both `game` and `player` globals here.")
  LOG.message ("This is run once per minute.")
  LOG.message ("This is good place for calling MOD.Update() function.")

  MOD.Update()

  LOG.message(MOD.id..".main.on_day_passed:END")

end

MOD.Init = function()

  LOG.message(MOD.id..".main.Init:START")

  LOG.message ("Initialization logic goes here.")

  LOG.message(MOD.id..".main.Init:END")

end

MOD.Update = function()

  LOG.message(MOD.id..".main.Update:START")

  LOG.message("You are running `dda` with following `dda-lua` mods:\n")

  for k,v in pairs(mods) do

    LOG.message("id     : %s", v.id)
    LOG.message("version: %s", v.version)
    LOG.message("\n")

  end

  LOG.message("\n")

  LOG.message ("Update logic goes here.")

  LOG.message(MOD.id..".main.Update:END")

end

MOD.on_game_loaded()
