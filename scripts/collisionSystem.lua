require 'scripts/gameSettings'
require 'scripts/playerSettings'
require 'scripts/enemySystem'
require 'scripts/lifeSystem'

function collision(x1, y1, w1, h1, x2, y2, w2, h2)
  return x2 < x1 + w1 and
         x1 < x2 + w2 and
         y2 < y1 + h1 and
         y1 < y2 + h2
end

function checkCollision()

  for i = #enemies, 1, -1 do
    if collision(banana.x, banana.y, banana.width, banana.height,
    enemies[i].x, enemies[i].y, enemies[i].width, enemies[i].height) then
    
      table.remove(enemies, i)
      direction = false
      KeepDirection = true
      score = score + 1
      if isAccuracy then
        shotsHit = shotsHit + 1
      end
    end
  end

  for i = #enemiesRed, 1, -1 do
    if collision(player.x, player.y, player.width, player.height,
    enemiesRed[i].x, enemiesRed[i].y, enemiesRed[i].width, enemiesRed[i].height) then
    
      table.remove(enemiesRed, i)
      score = score - 5
      playerLife = playerLife - 20
    end
  end

  for i = #livesRecover, 1, -1 do
    if collision(player.x, player.y, player.width, player.height,
    livesRecover[i].x, livesRecover[i].y, livesRecover[i].width, livesRecover[i].height) then
      
      playerLife = playerLife + 20
      table.remove(livesRecover, i)
    end
  end

end