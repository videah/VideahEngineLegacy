lighting = {}
lighting.shouldDraw = false

print("Loaded lighting engine ...")

function lighting.load()

	lighting.world = LightWorld({
		ambient = {55,55,55},
	})

	lightMouse = lighting.world:newLight(0, 0, 255, 100, 255, 100)
	
end

function lighting.update(dt)

	lighting.world:update(dt)
	lightMouse:setPosition(player:getPosition())

end
	
function lighting.draw()

end
