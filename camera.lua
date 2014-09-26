camera = {}
camera.x = 0
camera.y = 0

camera.scaleX = 0.5
camera.scaleY = 0.5
camera.rotation = 0
camera.lock = true

camera.shaking = false
camera.shaketype = "lock"
camera.intensity = 0
camera.shakeX = 0
camera.shakeY = 0

print("Loaded camera system ...")

function camera:set()

  --  Sets the scene by rotating and changing position of the camera.

  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)

end

function camera.update(dt)
  if camera.lock == true then
    camera:setPosition(player.fx - ((global.screenWidth / 2) * camera.scaleX), player.fy - ((global.screenHeight / 2) * camera.scaleY))
  end

  if camera.shaking == true then

    if camera.shaketype == "lock" then
      camera:setPosition(camera.shakeX + math.random(-camera.intensity, camera.intensity), camera.shakeY + math.random(-camera.intensity, camera.intensity))
    end

    if camera.shaketype == "player" then
        camera.shakeX, camera.shakeY = player:getPosition()
        camera.shakeX, camera.shakeY = camera.shakeX - (global.screenWidth / 2), camera.shakeY - (global.screenHeight / 2)
        camera.lock = false
        camera:setPosition(camera.shakeX + math.random(-camera.intensity, camera.intensity), camera.shakeY + math.random(-camera.intensity, camera.intensity))
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