state = {}

print("Loaded gamestate system ...")

state.currentState = "splash"

function state:changeState(input)
	state.currentState = input
end

function state:getState()
	return state.currentState
end	

function state:isStateEnabled(input)
	if input == state.currentState then
		return true
	else
		return false
	end
end