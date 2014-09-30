panel = {}

function panel.load()

	panel.x = 15
	panel.y = 15
	panel.width = 98
	panel.height = 34

end

function panel.draw()

	love.graphics.setColor(0,0,0,155)
	love.graphics.rectangle( "fill", panel.x, panel.y, panel.width, panel.height )
	love.graphics.setColor(255,255,255,255)

	love.graphics.setFont(font.debug)

	love.graphics.print("FPS: " .. global.fps, panel.x + 4, panel.y + 4)

end