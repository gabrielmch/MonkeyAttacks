require 'scripts/gameSettings'
require 'scripts/playerSettings'

banana = {
  x = player.x,
  y = player.y,
  width = 20,
  height = 20,
  posX = 0,
  posY = 0,
  rotation = 0
}

direction = false
keepDirection = true

function attackAssets()
  attackAin = love.graphics.newImage("images/interface/ain.png")
  attackBanana = love.graphics.newImage("images/interface/banana.png")
end

function attackMove(dt)
  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()

  function love.mousepressed(mouseX, mouseY, button)
    if button == 1 and not direction then
     
      angle = math.atan2((mouseY - banana.y), (mouseX - banana.x))

      banana.posX = math.cos(angle) * (900 + incrementSpeedDrop)
      banana.posY = math.sin(angle) * (900 + incrementSpeedDrop)
      direction = true

      if isAccuracy then
        shotsFired = shotsFired + 1
      end
    end
  end

  if direction and keepDirection then
    banana.x = banana.x + banana.posX * dt
    banana.y = banana.y + banana.posY * dt
  else
    banana.x = player.x
    banana.y = player.y
  end

  if banana.x > widthScreen or banana.x < 0 or banana.y > (heightScreen - 40) or banana.y < 0 then
    direction = false
    keepDirection = true
    if isAccuracy then
      shotsMissed = shotsMissed + 1
    end
  end

end

function attackDraw()
  love.graphics.draw(attackBanana, banana.x, banana.y, 0, 1, 1, -10)
  love.graphics.draw(attackAin, mouseX, mouseY, 0, 1, 1, attackAin:getWidth()/2, attackAin:getHeight()/2)
end