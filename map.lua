map = {}

function map.load()

	map.directory = "maps/"
	map.currentMap = sti.new(map.directory .. "test")

	map.Speed = 500

	love.physics.setMeter(32)

	world = love.physics.newWorld(0*love.physics.getMeter(), 0*love.physics.getMeter())

	collision = map.currentMap:initWorldCollision(world)

	print("Loaded map system ...")

end

function map.draw()

	map.currentMap:draw()

	map.currentMap:drawWorldCollision(collision)

	love.graphics.polygon("line", player.body:getWorldPoints(player.shape:getPoints()))

end

function map.update(dt)

	map.ftx, map.fty = math.floor(camera.x), math.floor(camera.y)

	if camera.lock ~= true then
		map.TempControls(dt)
	end

	world:update(dt)

end

function map.TempControls(dt)

	if love.keyboard.isDown("up") then camera:move(0, math.floor(-map.Speed * dt)) end
	if love.keyboard.isDown("down") then camera:move(0, math.floor(map.Speed * dt)) end
	if love.keyboard.isDown("left") then camera:move(math.floor(-map.Speed * dt), 0) end
	if love.keyboard.isDown("right") then camera:move(math.floor(map.Speed * dt), 0)  end

end

function map:changeMap(string)

	currentMap = sti.new(map.directory .. string)
	player.x = 0
	player.y = 0

end