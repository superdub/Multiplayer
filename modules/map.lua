   local map = {}


  map.height,map.width = display.viewableContentHeight ,display.viewableContentWidth


   map.group = display.newGroup()

  display.setDefault( "magTextureFilter", "nearest" )

  map.tiled = {}


  for i=1,map.height/32*2 do
    for j=1,map.width/32*2 do
      local image = display.newImage(map.group,"assets/glass.png",-32*8 + j*32,-32*8 + i*32)
      table.insert( map.tiled, image )
    end
  end



   return map
