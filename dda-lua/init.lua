--[[ DEBUG ]]--

DEBUG_ENABLED = false

--[[ Unnamed requirements ]]--

require("./data/mods/dda-lua/lua/functions")

--[[ Named requirements ]]--

json = require("./data/mods/dda-lua/lua/dkjson")
log = require("./data/mods/dda-lua/lua/log")
figlet = require("./data/mods/dda-lua/lua/figlet")
display = require("./data/mods/dda-lua/lua/display")
params = require("./data/mods/dda-lua/lua/params")

--[[ Globals initialization ]]--

LOG = log.init("./dda-lua.log", DEBUG_ENABLED or false, DEBUG_ENABLED or false)
PARAM = params.init()
FIGLET = figlet.init()
DISPLAY = display.init()

--[[

local skill_names = {

  "mechanics", "swimming", "bashing", "cutting", "melee", "throw",
  "driving", "survival", "tailor", "traps", "dodge", "stabbing", "unarmed",
  "barter", "computer", "cooking", "electronics", "fabrication", "firstaid", "speech",
  "archery", "gun", "launcher", "pistol", "rifle", "shotgun", "smg",
  "athletics"

}

local stat_names = {

  "squares_walked", "damage_taken", "damage_healed", "headshots"

}

]]--