player = {}

function player.load()

	player.name = "Player"
	player.speed = 3000
	player.x = 0
	player.y = 0

	player.sy = 0
	player.sx = 0

	player.fx, player.fy = math.floor(player.x), math.floor(player.y)

	player.body		= love.physics.newBody(world, player.x/2, player.y/2, "dynamic")
	player.shape	= love.physics.newRectangleShape(30, 30)
	player.fixture	= love.physics.newFixture(player.body, player.shape)

	player.body:setLinearDamping(10)

	print("Player created!")

end

function player.draw()

	love.graphics.rectangle("fill", math.floor(player.sx - 16), math.floor(player.sy - 16), 32, 32)

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

		love.graphics.printf(player.name, player.x + 16, player.y - 32, 0, 'center')

		love.graphics.setFont(font.default)

	end

end
function player:getPosition()
	return player.x, player.y
end