menu = {}

function menu.load()

	menu.Title = "VideahEngine"
	menu.titleimage = "data/images/videahenginelogo.png"
	menu.titletype = "image"

	menu.Image = "data/images/menubg.png"
	menu.Options = {"Start", "Multiplayer", "Quit"}
	menu.OptionsState = {"game", "multiplayer", "quit"}

	menu.Type = "scrolling_tiled"
	menu.ScrollDirection = "left"
	menu.ScrollSpeed = 50

	menu.InternalVariables()

	menu.GenerateMenuFrame()

	print("Loaded menu system ...")

end

function menu.draw()

	menu.GenerateBackground()
	menu.GenerateTitle()

end

function menu.update(dt)

	menu.CalculateScrolling(dt)

end

function menu.GenerateBackground()

	if menu.Type == "tiled" then

		menu.Image:setWrap('repeat', 'repeat')
		menu.bgQuad = love.graphics.newQuad( 0, 0, global.screenWidth, global.screenHeight, menu.Image:getHeight(), menu.Image:getWidth() )
		love.graphics.draw( menu.Image, menu.bgQuad, 0, 0)

	elseif menu.Type == "fill" then

		--TODO: Add code for more types of menu backgrounds.

	elseif menu.Type == "scrolling_tiled" then

		menu.Image:setWrap('repeat', 'repeat')
		menu.bgQuad = love.graphics.newQuad( menu.bgOffset, 0, global.screenWidth, global.screenHeight, menu.Image:getHeight(), menu.Image:getWidth() )
		love.graphics.draw( menu.Image, menu.bgQuad, 0, 0)

	elseif menu.Type == "color" then

		love.graphics.setColor(menubgRed, menubgGreen, menubgBlue, 255)
		love.graphics.rectangle( "fill", 0, 0, global.screenWidth, global.screenHeight )
		love.graphics.setColor(255, 255, 255, 255)

	end
end

function menu.GenerateTitle()

	if menu.titletype == "text" then
		love.graphics.setFont(font.menutitle)

		love.graphics.printf(menu.Title, 0, global.screenHeight / 10, global.screenWidth, 'center')

		love.graphics.setFont(font.default)
	end

	if menu.titletype == "image" then

		love.graphics.draw(menu.titleimage, (global.screenWidth / 2) - (menu.titleimage:getWidth() / 2), 0)

	end

end

function menu.GenerateMenuFrame()

	button = {}
	buttonStartPos = 30

	local menuframe = loveframes.Create("frame")
	menuframe:SetName("")
	menuframe:SetDraggable(false)
	menuframe:ShowCloseButton(false)
	menuframe:SetWidth(300)
	menuframe:SetHeight(30 + #menu.Options * 55)
	menuframe:Center()

	for i=1, #menu.Options, 1 do

		button[i] = loveframes.Create("button", menuframe)
		button[i]:SetText(menu.Options[i])
		button[i]:SetWidth(290)
		button[i]:SetHeight(50)
		button[i]:SetPos(5, buttonStartPos)
		buttonStartPos = buttonStartPos + 55
		button[i].OnClick = function(object, x, y)

			state:changeState(menu.OptionsState[i])

		end

	end

end

function menu.CalculateScrolling(dt)

	if menu.Type == "scrolling_tiled" then
		if menu.ScrollDirection == "left" then

			menu.bgOffset = menu.bgOffset + menu.ScrollSpeed * dt

		elseif menu.ScrollDirection == "right" then

			menu.bgOffset = menu.bgOffset - menu.ScrollSpeed * dt

		end
	end
end



function menu.InternalVariables()

	menu.Image = love.graphics.newImage( menu.Image )
	menu.titleimage = love.graphics.newImage( menu.titleimage )
	menu.bgOffset = 0

end