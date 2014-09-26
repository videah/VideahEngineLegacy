player = {}

function player.load()

	player.name = "Player"
	player.Speed = 200
	player.x = 0
	player.y = 0

	player.fx, player.fy = math.floor(player.x), math.floor(player.y)

	print("Player created!")

end

function player.draw()

	love.graphics.rectangle("fill", player.fx, player.fy, 32, 32)


	if state:isStateEnabled("multiplayer") then
		player:drawName(true)
	end

end

function player.update(dt)

	player.fx, player.fy = math.floor(player.x), math.floor(player.y)

	player.TempControls(dt)

end

function player.TempControls(dt)

	if love.keyboard.isDown("s") then player.y = player.y + (player.Speed *dt) end
	if love.keyboard.isDown("w") then player.y = player.y - (player.Speed *dt) end
	if love.keyboard.isDown("d") then player.x = player.x + (player.Speed *dt) end
	if love.keyboard.isDown("a") then player.x = player.x - (player.Speed *dt) end

end

function player:drawName(boolean)

	if boolean then

		love.graphics.setFont(font.playername)

		love.graphics.printf(player.name, player.x + 16, player.y - 32, 0, 'center')

		love.graphics.setFont(font.default)

	end

end
function player:getPosition()
	return player.x, player.y
end