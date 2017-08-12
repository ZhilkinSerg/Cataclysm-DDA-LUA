
REALITY_BUBBLE_WIDTH = 132
REALITY_BUBBLE_WIDTH_HALF = REALITY_BUBBLE_WIDTH / 2

function DisplayMessage (message)
	print(message)
	game.add_msg(tostring(message))
end

function DrawLine_Bresenham(x1, y1, x2, y2, fd)
  local delta_x = x2 - x1
  local ix = delta_x > 0 and 1 or -1
  delta_x = 2 * math.abs(delta_x)

  local delta_y = y2 - y1
  local iy = delta_y > 0 and 1 or -1
  delta_y = 2 * math.abs(delta_y)

  DrawPlot(x1, y1, fd)

  if delta_x >= delta_y then
    error = delta_y - delta_x / 2

    while x1 ~= x2 do
      if (error >= 0) and ((error ~= 0) or (ix > 0)) then
        error = error - delta_x
        y1 = y1 + iy
      end

      error = error + delta_y
      x1 = x1 + ix

      DrawPlot(x1, y1, fd)
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

      DrawPlot(x1, y1, fd)
    end
  end
end

function DrawPlot (x, y, fd)

	map:add_field(tripoint(x,y,player:pos().z), fd, 1, 0)

end

function AddItemToPlayerInventoryGeneric(item_id, item_quantity, container_id)

  item_quantity = math.floor(item_quantity)
  
  --local container

  if (item_quantity > 0) then
    
    local item = item(item_id, 1)

	--[[
    --local LIQUID = enums.phase_id[3]
    local LIQUID = enums.phase_id["LIQUID"]
  
    if (item.made_of(LIQUID) == true and container_id == nil) then
 
      local default_container_id = "bottle_plastic"   
      container_id = default_container_id
    
      container = item(container_id, 1)
    
      if (container:is_container() == false) then
    
        container_id = default_container_id
    
      end
    
    end
	]]
    
    if (container_id == nil) then
      
      item = item(item_id, item_quantity)
      player:i_add(item)
    
    else

      local container = item(container_id, 1)

      for i = 1, item_quantity do

        item = item(item_id, 1)
        container:fill_with(item)
        
        if (container:is_container_full() == true or i == item_quantity) then

          player:i_add(container)
          container = item(container_id, 1)

        end

      end
    
    end
  
  end

end

function AddItemToPlayerInventory(item_id, item_quantity)

  AddItemToPlayerInventoryGeneric(item_id, item_quantity)
 
end

function AddItemInContainerToPlayerInventory(item_id, item_quantity, container_id)

  AddItemToPlayerInventoryGeneric(item_id, item_quantity, container_id)
 
end