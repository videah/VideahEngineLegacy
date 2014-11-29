input = {}
input.keylist = {}
input.actionlist = {}
input.currentmb = ""

function input.load()

	if love.filesystem.exists("cfg/controls.ini") == false then
		local defaultSettings = 
		{
			controls = 
			{
				forward = 'w',
				backward = 's',
				left = 'a',
				right = 'd',
				sprint = 'lshift',
				nextwep = 'wu',
				prevwep = 'wd',
			},
		};

		LIP.save("cfg/controls.ini", defaultSettings)
	end

	local loadedSettings = LIP.load('cfg/controls.ini');

	--Player Movement
	input:bind(loadedSettings.controls.forward, "player.forward")
	input:bind(loadedSettings.controls.backward, "player.backward")
	input:bind(loadedSettings.controls.left, "player.left")
	input:bind(loadedSettings.controls.right, "player.right")

	input:bind(loadedSettings.controls.sprint, "player.sprint")

	input:bind(loadedSettings.controls.nextwep, "player.nextwep")
	input:bind(loadedSettings.controls.prevwep, "player.prevwep")

	input:bind(loadedSettings.controls.primaryfire, "player.primaryfire")


end

function input:bind(key, action)

	--TODO: Rebinding is currently broken, needs fixing.

	for i=0, #input.actionlist do
		if action == input.actionlist[i] then
			util.dprint("Replacing bind...")
			self.keylist[i] = key
			self.actionlist[i] = action
		elseif action ~= input.actionlist[i] and i == #input.actionlist then
			util.dprint("Binding " .. "'" .. action .. "'" .. " to " .. "'" .. key .. "'")
			table.insert(input.keylist, key)
			table.insert(input.actionlist, action)
		end
	end

end

function input.isDown(action)

	for i=0, #input.actionlist do
		if input.actionlist[i] == action then
			if love.keyboard.isDown(input.keylist[i]) then
				return true
			else
				return false
			end
		end
	end
end

function input.mouseIsDown(action)

	for i=0, #input.actionlist do
		if input.actionlist[i] == action then
			if love.mouse.isDown(input.keylist[i]) then
				return true
			else
				return false
			end
		end
	end
end

function input.mousePressed(action)

	for i=0, #input.actionlist do
		if input.actionlist[i] == action then
			if input.currentmb == input.keylist[i] then
				return true
			else
				return false
			end
		end
	end
end

function input.mousepressed( x, y, button)

	input.currentmb = button

end

function input.update(dt)

	input.currentmb = ""

end