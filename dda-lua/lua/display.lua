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
    popup_string = popup_string..v.."\n"
  end
  
  game.popup(popup_string) -- 79x22 max

end


return display