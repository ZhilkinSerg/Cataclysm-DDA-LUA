require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

  id = "dda-lua-traits",
  version = "2017-08-13"

}

mods[MOD.id] = MOD

function MOD.on_game_loaded() 

  LOG.message(MOD.id..".main.on_game_loaded:START")

  

  LOG.message(MOD.id..".main.on_game_loaded:END")

end

function MOD.on_new_player_created()

  LOG.message(MOD.id..".main.on_new_player_created:START")

  MOD.Init()
  MOD.Update()

  LOG.message(MOD.id..".main.on_new_player_created:END")

end

function MOD.on_skill_increased()

  LOG.message(MOD.id..".main.on_skill_increased:START")

  MOD.Update()

  LOG.message(MOD.id..".main.on_skill_increased:END")

end

function MOD.on_minute_passed()

  LOG.message(MOD.id..".main.on_minute_passed:START")

  MOD.Update()

  LOG.message(MOD.id..".main.on_minute_passed:END")

end

function MOD.on_day_passed()

  LOG.message(MOD.id..".main.on_day_passed:START")

  MOD.Update()  

  LOG.message(MOD.id..".main.on_day_passed:END")

end
  
MOD.TouretteTraitEffect = function()

  LOG.message(MOD.id..".main.MOD.TouretteTraitEffect:START")

  local tourette_chance_each_minute = game.one_in(20) --TODO: make this variable configurable

  local TouretteTraitWords = {
  
    "Fuck!",
    "Shit!",
    "Piss!",
    "Gosh!",
    "Fuckers!",
    "Idiot!",
    "AAAARRGH!!!",
    "Damn zeds!",
    "DIE!!!",
    "Motherfucker!",
    "Assholes!"
  }

  local tourette_word = table.random_value (TouretteTraitWords)

  local is_sleeping = player:in_sleep_state()
  local is_medicated = player:has_effect(efftype_id("took_xanax"))

  if (is_sleeping == false and is_medicated == false) then

    if (tourette_chance_each_minute == true) then

      player:shout(tourette_word)

      DISPLAY.popup_figlet(tourette_word, FIGLET.random_font())

    end

  end

  LOG.message(MOD.id..".main.MOD.TouretteTraitEffect:END|%s|%s|%s|%s", tourette_word, tourette_chance_each_minute, is_sleeping, is_medicated)

end

MOD.NudistTraitEffect = function()

  LOG.message(MOD.id..".main.MOD.NudistTraitEffect:START")

  local nude_effect = efftype_id("nude")
  local nude_effect_duration = TURNS(3600000) -- TODO: make this variable configurable

  local is_naked = true

  for _,body_part in pairs(enums.body_part) do

   if (player:wearing_something_on(body_part) == true) then

     is_naked = false

     break

   end

  end
  
  local has_nude_effect = player:has_effect(nude_effect)

  if (is_naked == true and has_nude_effect == false) then

    player:add_effect(nude_effect, nude_effect_duration)

  elseif (is_naked == false and has_nude_effect == true) then

    player:remove_effect(nude_effect)

  --[[
    local player_morale = player:get_morale_level()
    local player_morale_delta = 1 -- TODO: make this variable configurable or implement some smarter formula in `player_morale_new`
    local player_morale_new = player_morale + player_morale_delta

    --(player_morale_new)

    player:update_morale()

    LOG.message(player_morale, player_morale_new)
  ]]--

  end

  LOG.message(MOD.id..".main.MOD.NudistTraitEffect:END|%s", is_naked)

end

MOD.NightmaresTraitEffect = function()

  LOG.message(MOD.id..".main.MOD.NightmaresTraitEffect:START")

  local nightmare_chance_each_minute = game.one_in(200) --TODO: make this variable configurable

  local Nightmares = {
  
    "nightmare01",
    "nightmare02",
    "nightmare03",
    "nightmare04",
    "nightmare05",
    "nightmare06",
    "nightmare07",
    "nightmare08",
    "nightmare09",
    "nightmare10"

  }

  local nightmare = table.random_value (Nightmares)

  local is_sleeping = player:in_sleep_state()
  local is_medicated = player:has_effect(efftype_id("took_ambien"))

  if (is_sleeping == true and is_medicated == false) then

    if (nightmare_chance_each_minute == true) then

      game.add_msg("<color_magenta>You are having a nightmare!</color>")

      DISPLAY.popup_ascii(nightmare)

      player:wake_up()

    end

  end

  LOG.message(MOD.id..".main.MOD.NightmaresTraitEffect:END|%s|%s|%s|%s", nightmare, nightmare_chance_each_minute, is_sleeping, is_medicated)

end

MOD.DeafnessTraitEffect = function()

  LOG.message(MOD.id..".main.MOD.DeafnessTraitEffect:START")

  local deaf_effect = efftype_id("deaf")
  local deaf_effect_duration = TURNS(3600000) -- TODO: make this variable configurable
  local deaf_effect_body_part = "bp_head"
  local deaf_effect_intensity = 3
  local is_deaf = player:has_effect(deaf_effect)

  if (is_deaf == false) then
  
    player:add_effect(deaf_effect, deaf_effect_duration, deaf_effect_body_part, true, deaf_effect_intensity)

  end

  LOG.message(MOD.id..".main.MOD.DeafnessTraitEffect:END")

end

MOD.BlindnessTraitEffect = function()

  LOG.message(MOD.id..".main.MOD.BlindnessTraitEffect:START")

  local blind_effect = efftype_id("blind")
  local blind_effect_duration = TURNS(3600000) -- TODO: make this variable configurable
  local blind_effect_body_part = "bp_eyes"
  local blind_effect_intensity = 1
  local is_blind = player:has_effect(blind_effect)

  if (is_blind == false) then
  
    player:add_effect(blind_effect, blind_effect_duration, blind_effect_body_part, true, blind_effect_intensity)

  end

  LOG.message(MOD.id..".main.MOD.BlindnessTraitEffect:END")

end

MOD.Init = function()

  LOG.message(MOD.id..".main.MOD.Init:START")

  

  LOG.message(MOD.id..".main.MOD.Init:END")

end

MOD.Traits = {

  TOURETTE = MOD.TouretteTraitEffect,
  NUDIST = MOD.NudistTraitEffect,
  NIGHTMARES = MOD.NightmaresTraitEffect,
  DEAFNESS = MOD.DeafnessTraitEffect,
  BLINDNESS = MOD.BlindnessTraitEffect
  
}
  
MOD.Update = function()

  LOG.message(MOD.id..".main.MOD.Update:START")

  for trait_name,trait_function_name in pairs(MOD.Traits) do

    if (player:has_base_trait(trait_id(trait_name))) then

      trait_function_name()

    end

  end

  LOG.message(MOD.id..".main.MOD.Update:END")

end

MOD.on_game_loaded()
