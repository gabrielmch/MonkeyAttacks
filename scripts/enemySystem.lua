require 'scripts/gameSettings'

enemiesMax = 8
enemySpeed = 250
decreaseDelay = 0
enemyDelay = 0.5
enemyRedDelay = 4 - decreaseDelay

function enemyAssets()
  enemyImg = love.graphics.newImage("images/enemies/bird.png")
  enemyRedImg = love.graphics.newImage("images/enemies/birdRed.png")
end

enemies = {}
function enemyCreate()
  enemy = {
    x = math.random(200, widthScreen - 200),
    y = 620,
    width = 80,
    height = 80,
    speed = math.random(-enemySpeed, enemySpeed)
  }
  if enemy.speed >= 150 or enemy.speed <= -150 then
    table.insert(enemies,enemy)
  end
  if isRestart then
    enemyRemove()
    isRestart = false
  end
end

enemiesRed = {}
function enemyRedCreate()
  enemyRed = {
    x = -40,
    y = math.random(260, 285),
    width = 44,
    height = 22,
    speed = 300
  }
  table.insert(enemiesRed,enemyRed)
end

function enemyRemove()
  for i = #enemies, 1, -1 do
    if enemies[i].x > widthScreen + 20 or enemies[i].x < -20 then
      table.remove(enemies,i)
    end
    if #enemies > enemiesMax then
      table.remove(enemies,i)
    end
    if isRestart then
      table.remove(enemies,i)
    end
  end

end

function enemyRedRemove()
  for i = #enemiesRed, 1, -1 do  
    table.remove(enemiesRed,i)
  end
end

function enemySpawn(dt)

  enemyRemove()

  for k, enemy in pairs(enemies) do
    enemy.x = enemy.x + enemy.speed * dt
  end

  enemyDelay = enemyDelay - dt
  if enemyDelay <= 0 then
    enemyCreate()
    local leftover = math.abs(enemyDelay)
    enemyDelay = 0.4 - leftover
  end


  if score >= 20 then
    for k, enemyRed in pairs(enemiesRed) do
      enemyRed.x = enemyRed.x + enemyRed.speed * dt
    end
    enemyRedDelay = enemyRedDelay - dt
    if enemyRedDelay <= 0 then
      enemyRedCreate()
      local leftover = math.abs(enemyRedDelay)
      enemyRedDelay = math.random(4, 6) - leftover
    end
  else
    enemyRedRemove()
  end

end

function enemyDraw()
  for k,enemy in pairs(enemies) do
    love.graphics.draw(enemyImg, enemy.x, enemy.y)
  end
  
  for k,enemyRed in pairs(enemiesRed) do
    love.graphics.draw(enemyRedImg, enemyRed.x, enemyRed.y)
  end
  
end