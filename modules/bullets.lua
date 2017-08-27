local bullets = {}

function bullets:new(name)
  local private = {}
  local public = {}

  private.name = name
  private.mas =  {}
  private.explosions = require "modules.explosions":new()
  function public:add(x,y,dir,name)
    local bul = require "modules.bullet":new(x,y,dir)
    bul:setName(name)
    table.insert(private.mas,bul)
  end


  function private:enterFrame(event)
    self.explosions:update()
    for i,v in ipairs(self.mas) do
      v:update()
      if v:getDelete() then
        v:delete()
        table.remove(self.mas,i)
        self.explosions:add(v:getX(),v:getY())
      end
    end
  end

    Runtime:addEventListener("enterFrame",private)


    function public:getMas()
      return private.mas
    end

    function public:getName()
      return private.name
    end

  setmetatable( self, public )
  self.__index = self
  return public
end

return bullets
