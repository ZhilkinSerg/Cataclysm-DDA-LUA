display = {}

display.init = function()

  return display

end

display.popup_figlet = function (s, f)

  if (type(s) == "table") then

    for _,v in pairs(s) do
      display.popup_figlet(v, f)
    end

  else

  local t = FIGLET.ascii_art(s, f)

    display.popup_table(t)

  end

end

display.popup_ascii = function (i)

  if (type(i) == "table") then

    for _,v in pairs(i) do
      display.popup_ascii(v)
    end

  else

    local t = file.read_all("./data/mods/dda-lua/ascii/"..i..".txt")

    display.popup_table(t)

  end

end

display.popup_table = function (t)

  local popup_string = ""

  for _,v in pairs(t) do
    popup_string = popup_string..tostring(v).."\n"
  end
  
  game.popup(popup_string) -- 79x22 max

end

display.popup = function (s)
  
  game.popup(s) -- 79x22 max with \n on line end

end
display.message = function (message)

  print(message)
  game.add_msg(tostring(message))

end

display.line_field = function(x1, y1, x2, y2, fd)

  local delta_x = x2 - x1
  local ix = delta_x > 0 and 1 or -1
  delta_x = 2 * math.abs(delta_x)

  local delta_y = y2 - y1
  local iy = delta_y > 0 and 1 or -1
  delta_y = 2 * math.abs(delta_y)

  display.plot_field(x1, y1, fd)

  if delta_x >= delta_y then
    error = delta_y - delta_x / 2

    while x1 ~= x2 do
      if (error >= 0) and ((error ~= 0) or (ix > 0)) then
        error = error - delta_x
        y1 = y1 + iy
      end

      error = error + delta_y
      x1 = x1 + ix

      display.plot_field(x1, y1, fd)
    end
  else
    error = delta_x - delta_y / 2

    while y1 ~= y2 do
      if (error >= 0) and ((error ~= 0) or (iy > 0)) then
        error = error - delta_y
        x1 = x1 + ix
      end

      error = error + delta_x
      y1 = y1 + iy

      display.plot_field(x1, y1, fd)
    end
  end
end

display.plot_field = function (x, y, fd)

  map:add_field(tripoint(x,y,player:pos().z), fd, 1, TURNS(0))
  
end

return display