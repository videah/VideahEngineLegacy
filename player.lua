player = {}

function player.load()

	player.name = "Player"
	player.speed = 2500
	player.x = 0
	player.y = 0 -- TODO: Get starting position from map and set player position accordingly.
	player.size = 32

	player.sy = 0
	player.sx = 0

	player.fx, player.fy = math.floor(player.x), math.floor(player.y)

	player.body		= love.physics.newBody(world, player.x, player.y, "dynamic")
	player.shape	= love.physics.newRectangleShape(player.size, player.size)
	player.fixture	= love.physics.newFixture(player.body, player.shape)

	player.body:setLinearDamping(10)

	player:setTile(6,4) -- Temp positioning.

	print("Player created!")

end

function player.draw()

	love.graphics.rectangle("fill", math.floor(player.sx - 16), math.floor(player.sy - 16), player.size, player.size)

	if state:isStateEnabled("multiplayer") then
		player:drawName(true)
	end

end

function player.update(dt)

	player.fx, player.fy = math.floor(player.x), math.floor(player.y)

	player.body:setAngle(0)

	player.TempControls(dt)

	player.sx, player.sy =  player.body:getPosition()

end

function player.TempControls(dt)

	if love.keyboard.isDown("s") then 
		player.y = player.y + (player.speed *dt) 
		player.body:applyForce(0, player.speed)
	end

	if love.keyboard.isDown("w") then 
		player.y = player.y - (player.speed *dt) 
		player.body:applyForce(0, -player.speed)
	end

	if love.keyboard.isDown("d") then 
		player.x = player.x + (player.speed *dt) 
		player.body:applyForce(player.speed, 0)
	end

	if love.keyboard.isDown("a") then 
		player.x = player.x - (player.speed *dt) 
		player.body:applyForce(-player.speed, 0)
	end

end

function player:drawName(boolean)

	if boolean then

		love.graphics.setFont(font.playername)

		love.graphics.printf(player.name, player.sx + 16, player.sy - 32, 0, 'center')

		love.graphics.setFont(font.default)

	end

end

function player:getPosition()
	return player.sx, player.sy
end

function player:setPosition(x, y)
	player.body:setPosition(x, y)
end

function player:setTile(x, y)
	player.body:setPosition((x * 32) - (self.size / 2), (y * 32) - (self.size / 2))
end