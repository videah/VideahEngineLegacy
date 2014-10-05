camera = {}
camera.x = 0
camera.y = 0

camera.scaleX = 0.5
camera.scaleY = 0.5
camera.rotation = 0
camera.type = "mouse-locked"

camera.shaking = false
camera.shaketype = "lock"
camera.intensity = 0
camera.shakeX = 0
camera.shakeY = 0

camera.lmouseX = 0
camera.lmouseY = 0
camera.weight = 6

print("Loaded camera system ...")

function camera:set()

  --  Sets the scene by rotating and changing position of the camera.

  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)

end

function camera.update(dt)

  if camera.type == "locked" then
    camera:setPosition(math.floor(player.sx), math.floor(player.sy))
  end

  if camera.type == "mouse-locked" then

    camera.lmouseX = global.centerWidth - (global.mouseX - global.centerWidth * 2) / camera.weight
    camera.lmouseY = global.centerHeight - (global.mouseY - global.centerHeight * 2) / camera.weight

    camera:setPosition(math.floor(player.sx) - camera.lmouseX, math.floor(player.sy) - camera.lmouseY)

  end

  if camera.shaking == true then

    if camera.shaketype == "lock" then
      camera:setPosition(math.floor(camera.shakeX + math.random(-camera.intensity, camera.intensity)), math.floor(camera.shakeY + math.random(-camera.intensity, camera.intensity)))
    end

    if camera.shaketype == "player" then
        camera.shakeX, camera.shakeY = player:getPosition()
        camera.shakeX, camera.shakeY = math.floor(camera.shakeX - ((global.screenWidth / 2) * camera.scaleX)), math.floor(camera.shakeY - ((global.screenHeight / 2) * camera.scaleY))
        camera:setPosition(math.floor(camera.shakeX + math.random(-camera.intensity, camera.intensity)), math.floor(camera.shakeY + math.random(-camera.intensity, camera.intensity)))
    end

    if camera.intensity <= 0 then
      camera.shaking = false
    end

  end

end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self.x = math.floor(self.x + (dx or 0))
  self.y = math.floor(self.y + (dy or 0))
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function camera:lookAt(x, y)
  self.x = x - (global.centerWidth) * self.scaleX or self.x
  self.y = y - (global.centerHeight) * self.scaleY or self.y
end

function camera:setScale(s)
  self.scaleX = s or self.scaleX
  self.scaleY = s or self.scaleY
end

function camera:getPosition()
  return self.x, self.y
end

function camera:getScale()
  return self.scaleX, self.scaleY
end

function camera:getMousePosition()
  return love.mouse.getX() * self.scaleX + self.x, love.mouse.getY() * self.scaleY + self.y
end

function camera:getMouseX()
  return love.mouse.getX() * self.scaleX + self.x
end

function camera:getMouseY()
  return love.mouse.getY() * self.scaleY + self.y
end

function camera:setType(type)
  self.type = type
end

function camera:getType()
  return self.type
end

function camera:shake(intensity, duration)

  -- Note: Using this function will lock the camera in place.
  --  This is for use in cutscenes, or other places where the camera must be stationary.
  --  Use camera:playerShake() to shake the camera whilst locked onto the player

  self.shaking = true
  self.intensity = intensity or 0
  self.shaketype = "lock"

  self.shakeX, self.shakeY = camera:getPosition()

end

function camera:playerShake(intensity, duration)

  self.shaking = true
  self.intensity = intensity or 0
  self.shaketype = "player"

end

function camera:unshake()

  self.shaking = false

end
