map = {}

function map.load()

	map.directory = "maps/"
	map.currentMap = sti.new(map.directory .. "test2")

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

	world:update(dt)

end

function map:changeMap(string)

	currentMap = sti.new(map.directory .. string)
	player.x = 0
	player.y = 0
	player.sx = 0
	player.sy = 0

end