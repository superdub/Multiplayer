local camera = {}

function camera:new(joystick)
local private = {}
local public = {}

private.mas = {}

private.joystick = joystick
private.delta = 0.035




function public:add(item)
  table.insert(private.mas,item)
end



function public:delete(item)
   for i = 1,#private.mas do
     if private.mas[i] == item then
     table.remove(private.mas, i)
     else
       assert( private.mas[i],"error camera delete[i]  isn't found")
     end
   end
end

local offsetX = false
local offsetY = false
function private.mas:enterFrame(event)
  for i,v in ipairs(private.mas) do
    self[i]:translate(private.joystick:getX()*private.delta,private.joystick:getY()*private.delta)
  end
end

function public:scale(x,y)
  for i=1,#private.mas do
    private.mas[i]:scale(x,y)
  end
end

function public:rotate(x)
  for i=1,#private.mas do
    private.mas[i]:rotate(x)
  end
end

function public:setSpeed (speed)
  private.delta = speed
end

function public:getSpeed(speed)
  return private.delta
end

Runtime:addEventListener("enterFrame",private.mas)

setmetatable( self, public )
self.__index = self
return public
end


return camera
