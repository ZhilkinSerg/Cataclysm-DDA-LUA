local p = {}

p.init = function()

  return p

end

function p.add_item(item_id, item_quantity, container_id)

  if (item_quantity > 0) then

    item_quantity = math.floor(item_quantity)

    local LIQUID = enums.phase_id["LIQUID"]
    local item_ref = item(item_id, 1)
    local item_type = item_ref.type
    local item_type_phase = item_type.phase
    local item_default_container_id = item_type.default_container
	
	local cont = item(item_default_container_id, 1)
	
	--DISPLAY.message (tostring(cont:display_name()))
	--DISPLAY.message (tostring(cont:tname()))
	--DISPLAY.message (tostring(cont:type_name()))
	--DISPLAY.message (tostring(cont:typeId()))

    container_id = container_id or item_default_container_id

    if (container_id == "can_drink") then -- TODO: bugged container
      container_id = "bottle_plastic"
    end

    if (item_type_phase == LIQUID) then
      container_id = nil
    end

	--DISPLAY.message("def:"..tostring(container_id))
    
    if (container_id == nil or item_default_container_id == "null") then
      
      item_ref = item(item_id, item_quantity)
      player:i_add(item_ref)
    
    else

      local container = item(container_id, 1)

      for i = 1, item_quantity do

        item_ref = item(item_id, 1)
        container:fill_with(item_ref)

		--DISPLAY.message("rem-cap:"..tostring(container:get_remaining_capacity_for_liquid(item_ref, false)))
		--DISPLAY.message("is_full:"..tostring(container:is_container_full()))
		--DISPLAY.message("i:"..tostring(i))

        if (container:get_remaining_capacity_for_liquid(item_ref, false) == 0 or container:is_container_full() or i == item_quantity) then

          --player:i_add(item_ref)
          player:i_add(container)
          container = item(container_id, 1)

        end

      end
    
    end
  
  end

end

return p
