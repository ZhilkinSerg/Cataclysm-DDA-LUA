
REALITY_BUBBLE_WIDTH = 132
REALITY_BUBBLE_WIDTH_HALF = REALITY_BUBBLE_WIDTH / 2

function DisplayMessage (message)
	print(message)
	game.add_msg(tostring(message))
end

function DrawLine_Bresenham(x1, y1, x2, y2, fd)
  delta_x = x2 - x1
  ix = delta_x > 0 and 1 or -1
  delta_x = 2 * math.abs(delta_x)

  delta_y = y2 - y1
  iy = delta_y > 0 and 1 or -1
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