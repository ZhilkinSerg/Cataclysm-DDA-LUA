local params = {

  prefix = "dda-lua"

}

params.init = function()

  return params

end

params.convert = function(parameter_value, parameter_type)

  LOG.message("params.convert:START|%s|%s", parameter_value, parameter_type)

  if (parameter_type == "number") then
    parameter_value = tonumber(parameter_value or 0)
  elseif (parameter_type == "string") then
    parameter_value = tostring(parameter_value or "")
  else
    parameter_value = parameter_value
  end

  LOG.message("params.convert:END|%s|%s", parameter_value, parameter_type)
 
  return parameter_value

end

params.get = function(parameter_name, parameter_type)

  parameter_type = parameter_type or "number"

  LOG.message("params.get:START|%s|%s", parameter_name, parameter_type)

  local parameter_value

  if (string.find(parameter_name, "skill_") == 1) then

    local skill_name = string.gsub(parameter_name, "skill_", "")
    parameter_value = player:get_skill_level(skill_id(skill_name))

  elseif (string.find(parameter_name, "stats_") == 1) then

    local stat_name = string.gsub(parameter_name, "stats_", "")

    local save_info = player:save_info()
    local stats_start_token = "\"player_stats\":{"
    local stats_end_token = "}"
    local stats_start = string.find(save_info, stats_start_token) + string.len(stats_start_token) - string.len(stats_end_token)
    local stats_end = string.find(save_info, stats_end_token, stats_start)
    local stats_json = string.sub(save_info, stats_start, stats_end)

    local stats = json.decode(stats_json, 1, nil)

    parameter_value = stats[stat_name]

  else

    parameter_value = nil

    LOG.message("WARNING! getting %s parameter is not implemented yet!", parameter_name)

  end

  parameter_value = params.convert(parameter_value, parameter_type)

  LOG.message("params.get:END|%s|%s|%s", parameter_name, parameter_type, parameter_value)

  return parameter_value

end

params.save = function(parameter_name, parameter_value, parameter_type)

  parameter_type = parameter_type or "number"

  LOG.message("params.save:START|%s|%s|%s", parameter_name, parameter_type, parameter_value)

  parameter_value = params.convert(parameter_value, "string") --passed to function `parameter_type` is ignored as we are always saving as string

  player:set_value(params.prefix.."."..parameter_name, parameter_value)

  LOG.message("params.save:END|%s|%s|%s", parameter_name, parameter_type, parameter_value)

end

params.load = function (parameter_name, parameter_type)

  parameter_type = parameter_type or "number"

  LOG.message("params.load:START|%s|%s", parameter_name, parameter_type)

  local parameter_value = player:get_value(params.prefix.."."..parameter_name)

  parameter_value = params.convert(parameter_value, parameter_type)

  LOG.message("params.load:END|%s|%s|%s", parameter_name, parameter_type, parameter_value)

  return parameter_value

end

return params