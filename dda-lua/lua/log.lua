local log = {

  output_path = "./dda-lua.log",
  output_enabled = false,
  output_clear = false,
  datetime_format= "%Y-%m-%d %H:%M:%S"

}

log.init = function(output_path, output_enabled, output_clear)

  if (output_path ~= nil) then
    log.output_path = output_path
  end

  if (output_enabled ~= nil) then
    log.output_enabled = output_enabled
  end

  if (output_clear ~= nil) then
    log.output_clear = output_clear
  end

  if (log.output_clear == true) then

    local output_file = io.open (log.output_path, "w+")
    io.close(output_file)

  end

  return log

end

log.message = function(message_text, ...)

  if (log.output_enabled) then

    local message_text_formatted = ""

    if (#{...} > 0) then
      message_text_formatted = string.format(message_text, ...)
    else
      message_text_formatted = tostring(message_text)
    end

    local output_text = os.date(log.datetime_format).."|"..message_text_formatted.."\n"

    local output_file = io.open (log.output_path, "a")
    
    io.output(output_file)
    io.write(output_text)
    io.close(output_file)

  end

end

return log
