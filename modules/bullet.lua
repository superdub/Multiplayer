  local bullet = {}
  local W,H = display.contentWidth,display.contentHeight

  function bullet:new(x,y,dir,name)
    local private = {}
    local public = {}

    private.crypto = require "crypto"
    private.x,private.y,private.dir = x,y,dir
    private.speed = 2
    private.image = display.newImage("assets/bullet.png",private.x,private.y)
    private.image:scale(0.5,0.5)
    private.del = false
    private.count = 0
    private.name = "noName"
    private.randomNumber = math.random(0,10000)
    private.cod = math.random(0,1000).."."..math.random(0,1000).."."..math.random(100,1000)..private.randomNumber
    private.id = private.crypto.digest( crypto.md5,private.cod)

    function public:setDirection(dir)
      if dir == "left" then
        private.image:rotate(0)
      elseif dir == "side" then
        private.image:rotate(180)
      elseif dir == "up" then
        private.image:rotate(90)
      elseif dir == "down" then
        private.image:rotate(270)
      elseif dir == "up_l" then
        private.image:rotate(45)
      elseif dir == "up_d" then
        private.image:rotate(135)
      elseif dir == "down_l" then
        private.image:rotate(315)
      elseif dir == "down_d" then
        private.image:rotate(225)
      else
        private.image:rotate(270)
      end
    end

    public:setDirection(private.dir)


    function public:update()
      private.count = private.count + 1
      if private.dir == "left" then
        private.image.x = private.image.x - private.speed
      elseif private.dir == "side" then
        private.image.x = private.image.x + private.speed
      elseif private.dir == "up" then
        private.image.y = private.image.y - private.speed
      elseif private.dir == "down" then
        private.image.y = private.image.y + private.speed
      elseif private.dir == "up_l" then
        private.image.y = private.image.y - private.speed
        private.image.x = private.image.x - private.speed
      elseif private.dir == "up_d" then
        private.image.y = private.image.y - private.speed
        private.image.x = private.image.x + private.speed
      elseif private.dir == "down_l" then
        private.image.y = private.image.y + private.speed
        private.image.x = private.image.x - private.speed
      elseif private.dir == "down_d" then
        private.image.y = private.image.y + private.speed
        private.image.x = private.image.x + private.speed
      else
        private.image.y = private.image.y + private.speed
      end

      if private.image.y < 0 or private.image.y > H then
        private.del = true
      end
      if private.image.x < -W*0.1 or private.image.x > W*1.1 or private.count > 40 then
        private.del = true
      end
    end

    function public:getDelete()
      return private.del
    end

    function public:delete()
      private.image:removeSelf()
    end

    function public:getX()
      return private.image.x
    end

    function public:getY()
      return private.image.y
    end


    function public:getId()
      return private.id
    end

    function public:setId(id)
      private.id = id
    end

    function public:getName()
      return private.name
    end

    function public:setName(name)
     private.name = name
    end

    function public:getDirection()
      return private.dir
    end

    function public:getImage()
      return private.image
    end

    setmetatable(self,public)
    self.__index = self
    return public
  end


  return bullet
