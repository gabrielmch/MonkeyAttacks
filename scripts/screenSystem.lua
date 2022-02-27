require 'scripts/gameSettings'
require 'scripts/enemySystem'

function screensAssets()
  defeatScreen = love.graphics.newImage("images/screens/defeatScreen.png")
  pauseScreen = love.graphics.newImage("images/screens/pauseScreen.png")

  sbuttonDefault = love.graphics.newImage(
    "images/screens/buttons/button.png"
  )
  sbuttonSelected = love.graphics.newImage(
    "images/screens/buttons/buttonSelected.png"
  )
  playButton = love.graphics.newImage(
    "images/screens/buttons/buttonPlay.png"
  )
  restartButton = love.graphics.newImage(
    "images/screens/buttons/buttonRestart.png"
  )
  homeButton = love.graphics.newImage(
    "images/screens/buttons/buttonHome.png"
  )

  table.insert(sbuttons, newScreenButton(
    playButton,
    function()
        score = score
        seconds = seconds
        playerLife = playerLife
        isAccuracy = true
        isRestart = false
        isPause = false
        isDefeat = false
        isHowToPlay = false
        isMenu = false
    end))
    table.insert(sbuttons, newScreenButton(
    restartButton,
    function()
      if not isRestart then
        score = 0
        miliseconds = 0
        seconds = 0
        minutes = 0
        shotsHit = 0
        shotsFired = 0
        enemyMissed = 0
        incrementSpeedDrop = 0
        playerLife = 100
        isRestart = true
        isAccuracy = true
        isPause = false
        isDefeat = false
        isHowToPlay = false
        isMenu = false
      end
    end))
    table.insert(sbuttons, newScreenButton(
    homeButton,
    function()
      isMenu = true
      isGame = false
      isPause = false
      isDefeat = false
      isHowToPlay = false
    end))
end

sbuttons = {}

function newScreenButton(img, fn)
  return {
    img = img,
    fn = fn,
    now = false,
    last = false
  }
end

function drawScreenButtons()
  sbuttonW = sbuttonDefault:getWidth()
  sbuttonH = sbuttonDefault:getHeight()
  margin = 16
  totalWidth = (sbuttonW + margin) * #sbuttons
  cursorX = 0

  for i, sbutton in ipairs(sbuttons) do

    sbutton.last = sbutton.now

    dsbuttonX = (widthScreen * 0.5) - (sbuttonW * - 0.2) - (totalWidth * 0.5) + cursorX
    dsbuttonY = (heightScreen * 0.65) - (sbuttonH * 0.5)
    
    mx, my = love.mouse.getPosition()
    local focusDS = mx > dsbuttonX and mx < dsbuttonX + sbuttonW and
            my > dsbuttonY and my < dsbuttonY + sbuttonH

    sbuttonChange = sbuttonDefault

    if focusDS then
      sbuttonChange = sbuttonSelected

    elseif not focusDS then
      sbuttonChange = sbuttonDefault
    end

    sbutton.now = love.mouse.isDown(1)
    if sbutton.now and not sbutton.last and focusDS then
      sbutton.fn()
    end

    love.graphics.draw(
      sbuttonChange,
      dsbuttonX,
      dsbuttonY
    )
    
    love.graphics.draw(
      sbutton.img,
      dsbuttonX,
      dsbuttonY
    )

    cursorX = cursorX + (sbuttonW + margin)
  end

end

function drawScreenSituational()

  isMenu = false
  isHowToPlay = false
  isAccuracy = false
  love.mouse.setGrabbed(cursorOut)
  love.mouse.setVisible(visibleMouseOn)
  love.graphics.setFont(dataFont)

  if isPause and not isDefeat then
    love.graphics.draw(pauseScreen, 0, 0)
  elseif isDefeat and not isPause then
    love.graphics.draw(defeatScreen, 0, 0)
  end

  hitAccuracy = (shotsHit / (shotsFired + shotsMissed)) * 100
  hitAccuracy = math.floor(hitAccuracy + 0.5)

  if hitAccuracy >= 100 then
    hitAccuracy = 100
  end

  love.graphics.print(
    "Score: " .. 
    score .. 
    "  " .. 
    "Time: " .. 
    minutes .. 
    " : " .. 
    math.floor(seconds + 0.5) .. 
    "  " .. 
    "Accuracy: " .. 
    hitAccuracy .. "%",
    (widthScreen/2) - 255,
    heightScreen/2
  )

  drawScreenButtons()

end