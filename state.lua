state = {}

print("Loaded gamestate system ...")

state.currentState = "splash"

function state:changeState(input)
	self.currentState = input
end

function state:getState()
	return self.currentState
end	

function state:isStateEnabled(input)
	if input == self.currentState then
		return true
	else
		return false
	end
end