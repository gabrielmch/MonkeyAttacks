gameVersion = "0.1.2"

widthScreen = 1280
heightScreen = 720
score = 0
playerLife = 100
miliseconds = 0
seconds = 0
minutes = 0
shotsHit = 0
shotsFired = 0
shotsMissed = 0
incrementSpeedDrop = 0
lifeRecoverDelay = 8
isAccuracy = true
isMenu = true
isDefeat = false
isPause = false
isRestart = false
isGame = false
isHowToPlay = false

font = love.graphics.newFont("images/interface/04B_30__.TTF", 28)
gameFont = love.graphics.newFont("images/interface/04B_30__.TTF", 12)
dataFont = love.graphics.newFont("images/interface/04B_30__.TTF", 18)

function gameAssets()
  
  love.graphics.setFont(font)

  cursorIn = not love.mouse.isGrabbed()
  cursorOut = love.mouse.isGrabbed()

  visibleMouseOf = not love.mouse.isVisible()
  visibleMouseOn = love.mouse.isVisible()

  love.window.setTitle("Monkey Attacks!")
  love.window.setMode(widthScreen, heightScreen)

  background = love.graphics.newImage("maps/background.png")
  scoreboard = love.graphics.newImage("images/interface/scoreboard.png")
  starScore = love.graphics.newImage("images/interface/starScore.png")
  lifeRecoverImg = love.graphics.newImage("images/interface/lifeRecover.png")

  math.randomseed(os.time())
  
end

function gameScore()
  if score >= 50 then
    incrementSpeedDrop = 25
    if score >= 100 then
      love.graphics.draw(starScore, widthScreen/2 - 5, 135)
      if score >= 150 then
        incrementSpeedDrop = 50
        enemySpeed = 300
        if score >= 200 then
          love.graphics.draw(starScore, widthScreen/2 + 25, 135)
          incrementSpeedDrop = 75
          if score >= 250 then
            incrementSpeedDrop = 100
            enemySpeed = 350
            if score >= 300 then
              love.graphics.draw(starScore, widthScreen/2 + 55, 135)
            end
          end
        end
      end
    end
  end
  
end