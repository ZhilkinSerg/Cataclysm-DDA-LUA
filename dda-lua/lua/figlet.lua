-- Lua Figlet

--[[
  Based on figlet.

  FIGlet Copyright 1991, 1993, 1994 Glenn Chappell and Ian Chai
  FIGlet Copyright 1996, 1997 John Cowan
  Portions written by Paul Burton
  Internet: <ianchai@usa.net>
  FIGlet, along with the various FIGlet fonts and documentation, is
    copyrighted under the provisions of the Artistic License (as listed
    in the file "artistic.license" which is included in this package.

--]]

-- Converted to Lua by Nick Gammon
-- 23 November 2010

--[[
   Latin-1 codes for German letters, respectively:
     LATIN CAPITAL LETTER A WITH DIAERESIS = A-umlaut
     LATIN CAPITAL LETTER O WITH DIAERESIS = O-umlaut
     LATIN CAPITAL LETTER U WITH DIAERESIS = U-umlaut
     LATIN SMALL LETTER A WITH DIAERESIS = a-umlaut
     LATIN SMALL LETTER O WITH DIAERESIS = o-umlaut
     LATIN SMALL LETTER U WITH DIAERESIS = u-umlaut
     LATIN SMALL LETTER SHARP S = ess-zed
--]]

figlet = {

  default_font = "big",
  default_kern = false,
  default_smush = false

}

figlet.init = function (font, kern, smush)

  figlet.font = font or figlet.default_font
  figlet.kern = kern or figlet.default_kern
  figlet.smush = smush or figlet.default_smush

  return figlet

end


local figlet_fonts = {
  "big"          , --alpha/numeric
  --"bigfig"     ,   --alpha/numeric
  --"colossal"   ,   --alpha/numeric
  "doom"         , --alpha/numeric
  --"double"     ,   --alpha
  "epic"         , --alpha/numeric
  "ivrit"        , --alpha/numeric
  --"larry3d"      , --alpha/numeric
  --"lcd"        ,   --numeric
  --"mini"         , --alpha/numeric
  "ogre"         , --alpha/numeric
  "puffy"        , --alpha/numeric
  "small"        , --alpha/numeric
  "smslant"      , --alpha/numeric
  --"spliff"       , --alpha
  "standard"     , --alpha/numeric
  "stop"           --alpha/numeric
  --"straight"       --alpha/numeric
  --"threepoint"     --alpha/numeric?
}

figlet.random_font = function ()

  local random_font = table.random_value(figlet_fonts)
  
  if (random_font == nil or random_font == "") then
    random_font = figlet.default_font
  end

  return random_font

end


local deutsch = {196, 214, 220, 228, 246, 252, 223}

figlet.read_font_char = function (fontfile, theord)

  local t = {}
  fcharlist [theord] = t
  
  -- read each character line
  
  --[[
  
  eg.
  
  __  __ @
 |  \/  |@
 | \  / |@
 | |\/| |@
 | |  | |@
 |_|  |_|@
         @
         @@
--]]
           
  for i = 1, charheight do
    local line = assert (fontfile:read ("*l"), "Not enough character lines for character " .. theord)
    local line = string.gsub (line, "%s+$", "")  -- remove trailing spaces
    assert (line ~= "", "Unexpected empty line")
    
    -- find the last character (eg. @)
    local endchar = line:sub (-1) -- last character
    
    -- trim one or more of the last character from the end
    while line:sub (-1) == endchar do
      line = line:sub (1, #line - 1)
    end -- while line ends with endchar
    
    table.insert (t, line)
    
  end -- for each line

end -- figlet.read_font_char

-- read font file into memory (into table fcharlist)

figlet.read_font = function (filename)
  local fontfile = assert (io.open ("./data/mods/dda-lua/figlet/"..filename..".flf", "r"))
  local s
  
  fcharlist = {}

  -- header line
  s = assert (fontfile:read ("*l"), "Empty FIGlet file")
  
  -- eg.  flf2a$ 8 6          59     15     10        0             24463   153
  --      magic  charheight  maxlen  smush  cmtlines  ffright2left  smush2  ??
  
  -- configuration line
  magic, hardblank, charheight, maxlen, smush, cmtlines, ffright2left, smush2 =
      string.match (s, "^(flf2).(.) (%d+) %d+ (%d+) (%-?%d+) (%d+) ?(%d*) ?(%d*) ?(%-?%d*)")
     
  assert (magic, "Not a FIGlet 2 font file")
  
  -- convert to numbers
  charheight = tonumber (charheight) 
  maxlen = tonumber (maxlen) 
  smush = tonumber (smush) 
  cmtlines = tonumber (cmtlines)
  
  -- sanity check
  if charheight < 1 then
    charheight = 1
  end -- if

  -- skip comment lines      
  for i = 1, cmtlines do
    assert (fontfile:read ("*l"), "Not enough comment lines")
  end -- for
  
  -- get characters space to tilde
  for theord = string.byte (' '), string.byte ('~') do
    figlet.read_font_char(fontfile, theord)
  end -- for
    
  -- get 7 German characters
  for theord = 1, 7 do
    figlet.read_font_char(fontfile, deutsch[theord])
  end -- for
      
  -- get extra ones like:
  -- 0x0395  GREEK CAPITAL LETTER EPSILON
  -- 246  LATIN SMALL LETTER O WITH DIAERESIS

  repeat
    local extra = fontfile:read ("*l")
    if not extra then
      break
    end -- if eof
  
    local negative, theord = string.match (extra, "^(%-?)0[xX](%x+)")
    if theord then
      theord = tonumber (theord, 16)
      if negative == "-" then
        theord = - theord
      end -- if negative
    else
      theord = string.match (extra, "^%d+")
      assert (theord, "Unexpected line:" .. extra)
      theord = tonumber (theord)
    end -- if

    figlet.read_font_char(fontfile,theord)
    
  until false
      
  fontfile:close ()

  -- remove leading/trailing spaces
  
  for k, v in pairs (fcharlist) do
  
     -- first see if all lines have a leading space or a trailing space
     local leading_space = true
     local trailing_space = true
     for _, line in ipairs (v) do
       if line:sub (1, 1) ~= " " then
         leading_space = false
       end -- if
       if line:sub (-1, -1) ~= " " then
         trailing_space = false
       end -- if
     end -- for each line
     
     -- now remove them if necessary
     for i, line in ipairs (v) do
       if leading_space then
         v [i] = line:sub (2)
       end -- removing leading space
       if trailing_space then
         v [i] = line:sub (1, -2)
       end -- removing trailing space
     end -- for each line
  end -- for each character
  
end -- figlet.read_font_char

-- add one character to output lines
function figlet.add_char (which, output, kern, smush)
  local c = fcharlist [string.byte (which)]
  if not c then
    return
  end -- if doesn't exist
  
  for i = 1, charheight do
  
    if smush and output [i]~= "" and which ~= " " then 
      local lhc = output [i]:sub (-1)
      local rhc = c [i]:sub (1, 1)
      output [i] = output [i]:sub (1, -2)  -- remove last character
      if rhc ~= " " then
        output [i] = output [i] .. rhc
      else
        output [i] = output [i] .. lhc
      end       
      output [i] = output [i] .. c [i]:sub (2)
      
    else 
      output [i] = output [i] .. c [i]
    end -- if 
    
    if not (kern or smush) or which == " "  then
      output [i] = output [i] .. " "
    end -- if
  end -- for
  
end -- figlet.add_char

function figlet.ascii_art (s, font, kern, smush)

  font = font or figlet.default_font
  kern = kern or figlet.default_kern
  smush = smush or figlet.defualt_smush
  
  figlet.read_font (font)

  assert (fcharlist)
  assert (charheight > 0)
  
  -- make table of output lines
  local output = {}
  for i = 1, charheight do
    output [i] = ""
  end -- for
  
  for i = 1, #s do
    local c = s:sub (i, i)
    local c_index = 0
    if (c ~= nil) then
      c_index = string.byte(c)
    end
    if c_index >= 32 and c_index < 127 then
      figlet.add_char (c, output, kern, smush)
    end -- if in range
   
  end -- for

  -- fix up blank character so we can do a string.gsub on it
  local fixedblank = string.gsub (hardblank, "[%%%]%^%-$().[*+?]", "%%%1")

  for i, line in ipairs (output) do
    output [i] = string.gsub (line, fixedblank, " ")
  end -- for

  return output
end -- function figlet.ascii_art

return figlet