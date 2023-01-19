function love.load()
  width = 800
  height = 800
  love.window.setMode(width, height, {resizable=true, vsync=false, minwidth=800, minheight=800})
  canvas = love.graphics.newCanvas(4096,4096)

  blocs = {}
  blocs.herbe = {}
  blocs.herbe.herbe0 = love.graphics.newImage("Graphics/herbe0.png")
  
  blocs.eau = {}
  blocs.eau.eau0 = love.graphics.newImage("Graphics/eau0.png")
  
  blocs.sable = {}
  blocs.sable.sable0 = love.graphics.newImage("Graphics/sable0.png")
  
  blocs.montagne = {}
  blocs.montagne.montagne0 = love.graphics.newImage("Graphics/montagne0.png")
  
  blocs.neige = {}
  blocs.neige.neige0 = love.graphics.newImage("Graphics/neige0.png")
  personnage = love.graphics.newImage("Graphics/test.png")

  graine = 69
  tailleBlock = 16
  tailleCarteX = 100
  tailleCarteY = 100
  print(love.graphics.getSystemLimits().texturesize)
  pixelwidth, pixelheight = canvas:getPixelDimensions()
  print(pixelWidth, pixelHeight)

  noiseGrid = {}
  function generateNoiseGrid()
    local baseX = graine
    local baseY = graine
    for y = 1, tailleCarteY do
      noiseGrid[y] = {}
      for x = 1, tailleCarteX do
        noiseGrid[y][x] = love.math.noise(baseX+.01*x, baseY+.01*y)
      end
    end
  end
  generateNoiseGrid()

  love.graphics.setCanvas(canvas)
  for y=1,#noiseGrid do
    for x=1,tailleCarteX do
      noise = noiseGrid[y][x]
      --print(noise, y, y*tailleBlock, x, x*tailleBlock)
      if noise < 0.3 then
        love.graphics.draw(blocs.eau.eau0, x*tailleBlock, y*tailleBlock)
      elseif noise > 0.3 and noise < 0.4 then
        love.graphics.draw(blocs.sable.sable0, x*tailleBlock, y*tailleBlock)
      elseif noise > 0.4 and noise < 0.7 then
        love.graphics.draw(blocs.herbe.herbe0, x*tailleBlock, y*tailleBlock)
      elseif noise > 0.7 and noise < 0.85 then
        love.graphics.draw(blocs.montagne.montagne0, x*tailleBlock, y*tailleBlock)
      elseif noise > 0.85 then
        love.graphics.draw(blocs.neige.neige0, x*tailleBlock, y*tailleBlock)
      end
    end
  end
  love.graphics.setCanvas()
end

function love.draw()
  love.graphics.draw(canvas, -16, -16)
end