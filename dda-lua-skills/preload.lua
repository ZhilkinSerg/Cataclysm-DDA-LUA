require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

 id = "dda-lua-skills"

}

function on_preload()

  LOG.message(MOD.id..".preload.on_preload:START")

  

  LOG.message(MOD.id..".preload.on_preload:END")

end

on_preload()