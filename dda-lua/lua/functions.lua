function spairs(t)

  local keys = {}

  for k in pairs(t) do

    keys[#keys+1] = k

  end

  table.sort(keys)

  local i = -1

  return function()

    i = i + 1

    if keys[i] then

      return keys[i], t[keys[i]]

    end

  end

end

function spairs_reverse(t, order)

  local keys = {}

  for k in pairs(t) do

    keys[#keys+1] = k

  end

  table.sort(keys)

  keys_reverse = table.reverse(keys)

  local i = -1

  return function()

    i = i + 1

    if keys_reverse[i] then

      return keys_reverse[i], t[keys_reverse[i]]

    end
  end

end

function table.add (t, v)

  table.insert(t, v)

end

function table.random_value (t)

  local f = true
  local tf = {}
  if (f) then
    for _, v in pairs(t) do
    if (type(v) ~= "function" ) then
      table.insert(tf, v)
    end
    end
  else
    tf = t
  end
  
  local choice
  local n = 0
  for _, o in pairs(tf) do
    n = n + 1
    if (math.random() < (1/n)) then
      choice = o    
    end
  end
  return choice 
 
end

function table.reverse(t)

    local size = #t
    local t_reversed = {}
    for i,v in ipairs (t) do
        t_reversed[size-i] = v
    end
    return t_reversed

end

file = {}

file.exists = function (file_name)

  local f = io.open(file_name, "rb")
  if f then f:close() end
  return f ~= nil

end

file.read_all = function (file_name)

  if not file.exists(file_name) then return {} end
  local all_lines = {}
  for line in io.lines(file_name) do 
    all_lines[#all_lines + 1] = line
  end
  return all_lines

end

function string.from_file(file_name)

  local all_lines = file.read_all(file_name)
  return all_lines

end
