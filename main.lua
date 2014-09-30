---------------------------------------------------------------------------------------------------
-- Imports

require 'util/audio'
require 'util/input'

require 'util/debug'
require 'util/console'

require 'util.ease'

m_math 		= require 'util/math'
m_collide 	= require 'util/collide'

require 'menu'
require 'fonts'
require 'map'
require 'player'
require 'camera'
require 'state'
require 'splash'
require 'panel'

---------------------------------------------------------------------------------------------------
-- Libraries

require 'libs/LoveFrames'

sti = require 'libs/STI'
flux = require 'util/flux'

---------------------------------------------------------------------------------------------------
-- Global variables
global = {}

global.screenWidth = love.graphics.getWidth()
global.screenHeight = love.graphics.getHeight()

global.version = "0.0.2"
global.debug = true

global.state = "game"

---------------------------------------------------------------------------------------------------
-- Main collide

function love.load()

	splash.load()

	panel.load()

	font.load()
	
	menu.load()

	map.load()

	player.load()

	print("Welcome to VideahEngine " .. global.version .. " !")

end

function love.draw()

	if state:isStateEnabled("game") or state:isStateEnabled("multiplayer") then

		camera:set()

		map.draw()

		player.draw()

		camera:unset()

	end

	if state:isStateEnabled("splash") then

		splash.draw()

	end

	if state:isStateEnabled("menu") then

		menu.draw()

		loveframes.draw()

	end

	global.fps = love.timer.getFPS()

	panel.draw()

end

function love.update(dt)

	flux.update(dt)

	love.audio.update()

	if state:isStateEnabled("game") then

		map.update(dt)
		player.update(dt)
		camera.update(dt)
		
	end

	if state:isStateEnabled("multiplayer") then

		map.update(dt)

	end

	if state:isStateEnabled("menu") then

		menu.update(dt)
		loveframes.update()

	end

	if state:isStateEnabled("quit") then

		love.event.quit()

	end

end

function love.keypressed(key, isrepeat)

	if state:isStateEnabled("splash") == false then
		if key == "escape" then

			state:changeState("menu")

		end
	end

	if key == "y" then

		ease.ToggleBoolean(camera.lock)

	end

	if state:isStateEnabled("splash") then
		splash.keypressed(key, isrepeat)
	end

	loveframes.keypressed(key, isrepeat)

end

function love.mousepressed(x, y, button)
 
    -- your code
 
    loveframes.mousepressed(x, y, button)
 
end
 
function love.mousereleased(x, y, button)
 
    -- your code
 
    loveframes.mousereleased(x, y, button)
 
end
 
function love.keyreleased(key)
 
    -- your code
 
    loveframes.keyreleased(key)
 
end

function love.textinput(text)
             
    -- your code
 
    loveframes.textinput(text)
 
end

function love.quit()

	print("Shutting down ...")

end
