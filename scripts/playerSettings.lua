require 'scripts/gameSettings'

player = {
  src = "images/player/player.png",
  x = widthScreen / 2,
  y = 290,
  width = 80,
  height = 80,
  speed = 250,
  jumpForce = 0
}
gravity = 1000
maxJump = 500

function playerAssets()
  player.image = love.graphics.newImage(player.src)
  playerShadow = love.graphics.newImage("images/player/playerShadow.png")
  playerLifeImg = love.graphics.newImage("images/player/playerLife.png")
end

function playerMove(dt)

  if love.keyboard.isDown('d') then
    player.x = player.x + player.speed * dt
    if player.x > 1150 then
      player.x = player.x - player.speed * dt
    end
  end
  if love.keyboard.isDown('a') then
    player.x = player.x - player.speed * dt
    if player.x < 100 then
      player.x = player.x + player.speed * dt
    end
  end

  function love.keypressed(key)
    if key == "space" then
      if player.jumpForce == 0 then
        player.jumpForce = maxJump
      end
    end
  end

  if player.jumpForce ~= 0 then
    player.y = player.y - player.jumpForce * dt
    player.jumpForce = player.jumpForce - gravity * dt
      if player.y > 290 then
        player.jumpForce = 0
        player.y = 290
      end
  end

end

function playerDraw()
  love.graphics.draw(playerShadow, player.x, 290)
  love.graphics.draw(player.image, player.x, player.y)

  if playerLife >= 20 then
    love.graphics.draw(playerLifeImg, 50, 50)
    if playerLife >= 40 then
      love.graphics.draw(playerLifeImg, 110, 50)
      if playerLife >= 60 then
        love.graphics.draw(playerLifeImg, 170, 50)
        if playerLife >= 80 then
          love.graphics.draw(playerLifeImg, 230, 50)
          if playerLife == 100 then
            love.graphics.draw(playerLifeImg, 290, 50)
          end
        end
      end
    end
  end
  
end