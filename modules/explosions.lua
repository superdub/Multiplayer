  local explosions = {}


  function explosions:new()
    local public = {}
    local private = {}

    private.mas = {}


    function public:add(x,y)
       local explos = require "modules.explosion":new(x,y)
       table.insert(private.mas,explos)
    end

    function public:update()
      for i,v in ipairs(private.mas) do
         v:update()
         if v:getDelete() then
           table.remove(private.mas,i)
         end
      end
    end

    function public:getExplosions()
      return private.mas
    end

    setmetatable( self, public )
    self.__index = self
    return public
  end


  return explosions
