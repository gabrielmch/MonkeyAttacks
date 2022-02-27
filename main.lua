require 'scripts/gameSettings'
require 'scripts/screenSystem'
require 'scripts/menuSystem'
require 'scripts/playerSettings'
require 'scripts/collisionSystem'
require 'scripts/attackSystem'
require 'scripts/enemySystem'
require 'scripts/lifeSystem'

function love.load()
  menuAssets()
  screensAssets()
  gameAssets()
  playerAssets()
  attackAssets()
  enemyAssets()
end

function love.update(dt)

  if playerLife == 0 then
    isDefeat = true
  elseif isGame and not isDefeat and not isPause then
    playerMove(dt)
    attackMove(dt)
    enemySpawn(dt)
    lifeRecoverSpawn(dt)
    checkCollision()

    if love.keyboard.isDown("escape") and not isDefeat then
      isPause = true
      isMenu = false
      isRestart = false
      isHowToPlay = false
    end

    seconds = seconds + 1 * dt
    if seconds >= 60 then
      seconds = 0
      minutes = minutes + 1
      decreaseDelay = decreaseDelay + 0.5
    end

  end

end

function love.draw()

  if isMenu or isPause or isDefeat then
    love.mouse.setGrabbed(cursorOut)
    love.mouse.setVisible(visibleMouseOn)
  end
  
  drawMenu()
  love.graphics.print("Version: " .. gameVersion, dataFont, 20, 20)
  
  if isGame and not isMenu then
    love.graphics.setFont(gameFont)
    love.mouse.setVisible(visibleMouseOf)
    if isGame and not isPause and not isDefeat then
      love.mouse.setGrabbed(cursorIn)
    end
    love.graphics.draw(background, 0, 0)

    lifeRecoverDraw()
    playerDraw()
    enemyDraw()
    love.graphics.draw(scoreboard, (widthScreen/2) - 20, 70/2)
    love.graphics.print("Score: " .. score, widthScreen/2 - 7, 85)
    gameScore()
    attackDraw()

    love.graphics.print("Time: " .. minutes .. " : " .. math.floor(seconds + 0.5), dataFont, 1000, 85)

  end
  if not isMenu and isDefeat or isPause then
    drawScreenSituational()
  end
  if isHowToPlay and not isGame and not isMenu then
    drawHowToPlay()
  end
end