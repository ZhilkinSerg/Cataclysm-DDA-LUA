require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

 id = "dda-lua"

}

function on_preload()

  LOG.message(MOD.id..".preload.on_preload:START")

  LOG.message ("You can use `game` global, but cannot use `player` global here.")
  LOG.message ("This is run before character selection screen is loaded right before `main.lua` is executed.")
  LOG.message ("Good place for registering item_actions and redefining item and monster groups.")

  LOG.message(MOD.id..".preload.on_preload:END")

end

on_preload()