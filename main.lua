---------------------------------------------------------------------------------------------------
-- Imports

require 'util/audio'
require 'util/input'

require 'util/debug'
LIP = require 'util/LIP'

require 'util/util'

m_math 		= require 'util/math'
m_collide 	= require 'util/collide'
socket = require 'socket'

require 'menu'
require 'fonts'
require 'map'
require 'player'
require 'camera'
require 'state'
require 'splash'
require 'panel'
require 'network'
require 'hud'
require 'lighting'
require 'global'
require 'input'
require 'options'
require 'weapon'
require 'cursor'

---------------------------------------------------------------------------------------------------
-- Libraries

require 'libs/LoveFrames'

sti = require 'libs/STI'
jumper = require 'libs/Jumper'
flux = require 'util/flux'


---------------------------------------------------------------------------------------------------
-- Main

function love.load()

	options.load()

	global.debug = options.settings.settings.debug

	love.mouse.setGrabbed(true)	

	cursor.load()

	love.mouse.setCursor(cursor.cursor)

	love.graphics.setBackgroundColor(35, 65, 85)

	map.load()

	network.load()

	hud.load()

	splash.load()

	panel.load()

	font.load()
	
	input.load()

	menu.load()

	weapon.load()

	player.load()

	lighting.load()

	print("Welcome to VideahEngine " .. global.version .. " !")

end

function love.draw()

	if state:isStateEnabled("game") or state:isStateEnabled("multiplayer") then

		camera:set()

		map.draw()

		bullet.draw()

		player.draw()

		camera:unset()

		hud.draw()

		-- cursor.crosshair.draw()

	end

	if state:isStateEnabled("splash") then

		splash.draw()

	end

	if state:isStateEnabled("menu") then

		menu.draw()

		loveframes.draw()

	end

	if state:isStateEnabled("options") then

		menu.GenerateBackground()

		loveframes.draw()

	end

	global.fps = love.timer.getFPS()

	panel.draw()

end

function love.update(dt)

	global.update(dt)

	flux.update(dt)

	love.audio.update()

	if state:isStateEnabled("game") then

		map.update(dt)
		player.update(dt)
		camera.update(dt)
		lighting.update(dt)
		hud.update(dt)
		bullet.update(dt)
		--love.mouse.setVisible(false)
		
	end

	if state:isStateEnabled("multiplayer") then

		map.update(dt)

	end

	if state:isStateEnabled("menu") or state:isStateEnabled("options") then

		menu.update(dt)
		loveframes.update()
		love.mouse.setVisible(true)
		love.mouse.setCursor(cursor.cursor)

	end

	if state:isStateEnabled("options") then

		loveframes.SetState("options")

	end

	if state:isStateEnabled("menu") then

		loveframes.SetState("menu")

	end

	if state:isStateEnabled("quit") then

		love.event.quit()

	end

	input.update(dt)

end

function love.keypressed(key, isrepeat)

	if state:isStateEnabled("splash") == false then
		if key == "escape" then

			state:changeState("menu")

		end
	end

	if state:isStateEnabled("splash") then
		splash.keypressed(key, isrepeat)
	end

	loveframes.keypressed(key, isrepeat)

end

function love.mousepressed(x, y, button)
 
    -- your code
 
    input.mousepressed(x, y, button)

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