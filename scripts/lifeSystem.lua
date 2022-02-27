require 'scripts/gameSettings'

livesRecover = {}
function lifeRecoverCreate()
  lifeRecovers = {
    x = math.random(280, widthScreen - 280),
    y = 250,
    width = 20,
    height = 21,
  }
  table.insert(livesRecover,lifeRecovers)
end

function lifeRecoverRemove()
  for i = #livesRecover, 1, -1 do
    if playerLife >= 100 then
      table.remove(livesRecover,i)
    end
  end
end

function lifeRecoverSpawn(dt)

  if playerLife < 100 and #livesRecover <= 1 then
    lifeRecoverDelay = lifeRecoverDelay - dt
    if lifeRecoverDelay <= 0 then
      lifeRecoverCreate()
      local leftover = math.abs(lifeRecoverDelay)
      lifeRecoverDelay = 8 - leftover
    end
  else 
    lifeRecoverRemove()
  end
  
end

function lifeRecoverDraw()
  for k,lifeRecovers in pairs(livesRecover) do
    love.graphics.draw(lifeRecoverImg, lifeRecovers.x, lifeRecovers.y)
  end 
end