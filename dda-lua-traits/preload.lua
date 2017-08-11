require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

MOD = {

 id = "dda-lua-traits"

}

function on_preload()

  LOG.message(MOD.id..".preload.on_preload:START")

  

  LOG.message(MOD.id..".preload.on_preload:END")

end

on_preload()