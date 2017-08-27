  local dead = {}

  local d = {}

  function d:new(x,y)
    local private = {}
    local public = {}

    private.x,private.y = x,y
    private.count = 0

    private.isDead = false

    private.image = display.newImage("assets/blood.png",private.x,private.y)
    private.image:scale(0.2,0.2)


    function public:update()
        private.count = private.count + 1
        if private.count > 1000 then
          private.image:removeSelf()
          private.isDead = true
        end
    end

    function public:getDead()
      return private.isDead
    end

    setmetatable( self, public )
    self.__index = self
    return public
  end


  function dead:new()
    local private = {}
    local public = {}

    private.mas = {}

    function private:enterFrame(event)
      for i,v in ipairs(self.mas) do
        v:update()
        if v:getDead() then
          table.remove(self.mas,i)
        end
      end
    end

    function public:add(x,y)
      local dead = d:new(x,y)
      table.insert(private.mas,dead)
    end

    Runtime:addEventListener("enterFrame",private)


    setmetatable( self, public )
    self.__index = self
    return public
  end



  return dead
