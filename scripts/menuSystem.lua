require 'scripts/gameSettings'

function menuAssets()
  menuBackground = love.graphics.newImage("images/menu/menuBackground.png")
  howtoplayBackground = love.graphics.newImage("images/menu/howtoplayBackground.png")
  menuButton = love.graphics.newImage("images/menu/menuButton.png")
  menuButtonSelect = love.graphics.newImage("images/menu/menuButtonSelect.png")

  table.insert(buttons, newButton(
    "Start Game",
    function()
      isGame = true
      isMenu = false
      isHowToPlay = false
    end))
  table.insert(buttons, newButton(
    "How To Play",
    function()
      isHowToPlay = true
      isMenu = false
      isGame = false
    end))
    table.insert(buttons, newButton(
    "Settings",
    function()
      isMenu = true
      isHowToPlay = false
      isGame = false
    end))
  table.insert(buttons, newButton(
    "Exit",
    function()
      if isMenu then
        love.event.quit(0)
      end
    end))
end

buttons = {}

function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
end

buttonChangeMenu = menuButton
buttonChangeHTP = menuButton

function drawMenu()
  buttonWidth = menuButton:getWidth()
  buttonHeight = menuButton:getHeight()
  margin = 16
  totalHeight = (buttonHeight + margin) * #buttons
  cursorY = 0

  love.graphics.draw(menuBackground, 0, 0)

  
    for i, button in ipairs(buttons) do

      button.last = button.now
  
      bx = (widthScreen * 0.5) - (buttonWidth * 0.5)
      by = (heightScreen * 0.5) - (buttonHeight * - 0.2) - (totalHeight * 0.5) + cursorY
      textW = font:getWidth(button.text)
      textH = font:getHeight(button.text)
  
      local mx, my = love.mouse.getPosition()
      local focus = mx > bx and mx < bx + buttonWidth and
              my > by and my < by + buttonHeight
  
      if focus then
        buttonChangeMenu = menuButtonSelect
      elseif not focus then
        buttonChangeMenu = menuButton
      end
      
      if isMenu then
        button.now = love.mouse.isDown(1)
        if button.now and not button.last and focus then
          button.fn()
        end
      end
  
      love.graphics.draw(
        buttonChangeMenu,
        bx,
        by
      )
  
      love.graphics.print(
        button.text,
        font,
        (bx * 1.3) - textW * 0.5,
        by + textH * 1
      )
      
      cursorY = cursorY + (buttonHeight + margin)
    end
  
end

function drawHowToPlay()
  htpButtonW = menuButton:getWidth()
  htpButtonH = menuButton:getHeight()
  totalWidth = (htpButtonW + margin) * #buttons
  cursorX = 0
  love.graphics.draw(howtoplayBackground, 0, 0)
  bxHTP = (widthScreen * 0.5) - (htpButtonW * 1.5)
  byHTP = (heightScreen * 0.5) - (htpButtonH * -1.2)
    
  local mx, my = love.mouse.getPosition()
  local focusHTP = mx > bxHTP and mx < bxHTP + htpButtonW and
                    my > byHTP and my < byHTP + htpButtonH

  if focusHTP then
    buttonChangeHTP = menuButtonSelect
  elseif not focusHTP then
    buttonChangeHTP = menuButton
  end

  local buttonLast = buttonNow
  local buttonNow = love.mouse.isDown(1)
  if buttonNow and not buttonLast and focusHTP then
    isHowToPlay = false
    isMenu = true
  end

  love.graphics.draw(buttonChangeHTP, bxHTP, byHTP)
  love.graphics.print(
    "Return Menu", 
    font, 
    (bxHTP * 1.3) - textW * 0.5, 
    byHTP + textH * 1
  )

  cursorX = cursorX + (htpButtonW + margin)
end

function drawSettings()  
end