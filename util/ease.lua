ease = {}

function ease.ToggleBoolean( inputvar )

	print(inputvar)

	if inputvar == true then
		
		inputvar = not inputvar

		print("Switched boolean to false")

	elseif inputvar == false then

		inputvar = not inputvar

		print("Switched boolean to true")

	end

end

function ease.getTimestamp()

  return os.date("%x_%X"):gsub("[/:]", "-")

end