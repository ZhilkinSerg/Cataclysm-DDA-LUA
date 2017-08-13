require("./data/mods/dda-lua/init")

--[[ Modification code ]]--

local MOD = {

  id = "dda-lua-skills",
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

  

  LOG.message(MOD.id..".main.on_day_passed:END")

end

MOD.CalculateSpeedBonus = function()

  LOG.message(MOD.id..".main.CalculateSpeedBonus:START")

  local speed_bonus_factor = 2 --TODO: make this variable configurable or implement some smarter formula for `speed_bonus`
  local speed_bonus = PARAM.get("skill_athletics") * speed_bonus_factor

  LOG.message(MOD.id..".main.CalculateSpeedBonus:END|%s", speed_bonus)

  return speed_bonus

end

MOD.RemoveSpeedBonus = function()

  LOG.message(MOD.id..".main.RemoveSpeedBonus:START")

  local speed_bonus = PARAM.load("speed_bonus")
  local speed_base = tonumber(player:get_speed_base())
  local speed_base_new = speed_base

  if (speed_bonus) then

    speed_base_new = speed_base - speed_bonus 

    player:set_speed_base (speed_base_new)

  end

  LOG.message(MOD.id..".main.RemoveSpeedBonus:END|%s|%s|%s", speed_bonus, speed_base, speed_base_new)

end

MOD.ApplySpeedBonus = function()

  LOG.message(MOD.id..".main.ApplySpeedBonus:START")

  MOD.RemoveSpeedBonus()

  local speed_bonus = MOD.CalculateSpeedBonus()
  local speed_base = tonumber(player:get_speed_base())
  local speed_base_new = speed_base + speed_bonus

  player:set_speed_base (speed_base_new)

  PARAM.save("speed_bonus", speed_bonus)

  LOG.message(MOD.id..".main.ApplySpeedBonus:END|%s|%s|%s", speed_bonus, speed_base, speed_base_new)

end

MOD.PracticeSkill = function(skill_name, trained_amount)

  LOG.message(MOD.id..".main.PracticeSkill:START")

  player:practice(skill_id(skill_name), trained_amount)

  LOG.message(MOD.id..".main.PracticeSkill:END|%s|%s", skill_name, trained_amount)

end

MOD.Init = function()

  LOG.message(MOD.id..".main.Init:START")

  PARAM.save("squares_walked_total", 0)
  PARAM.save("stats_squares_walked", 0)
  PARAM.save("speed_bonus", 0)

  LOG.message(MOD.id..".main.Init:END")

end

MOD.Update = function()

  LOG.message(MOD.id..".main.Update:START")

  MOD.ApplySpeedBonus()

  local squares_walked_prev = PARAM.load("stats_squares_walked")
  local squares_walked = PARAM.get("stats_squares_walked")

  local squares_walked_delta = squares_walked - squares_walked_prev

  PARAM.save("stats_squares_walked", squares_walked)

  local squares_walked_total = PARAM.load("squares_walked_total")
  squares_walked_total = squares_walked_total + squares_walked_delta

  PARAM.save("squares_walked_total", squares_walked_total)

  local squares_per_train = 10 --TODO: make this variable configurable or implement some smarter formula for `trained_amount`
  local trained_amount = squares_walked_delta / squares_per_train

  if (trained_amount > 0 and trained_amount < 1) then

    trained_amount = 1

  end

  trained_amount = math.floor(trained_amount)

  MOD.PracticeSkill("athletics", trained_amount)

  LOG.message(MOD.id..".main.Update:END|%s|%s|%s|%s", squares_walked_prev, squares_walked, squares_walked_delta, trained_amount)

end

MOD.on_game_loaded()
