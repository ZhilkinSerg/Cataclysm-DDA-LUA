function player.add_item(item_id, item_quantity, container_id)

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