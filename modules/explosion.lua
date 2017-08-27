  local explosion = {}

  function explosion:new(x,y)
    local public = {}
    local private = {}

    private.group = display.newGroup()
    private.count = 0
    private.x = x
    private.y = y
    private.timer = 0
    private.sheetInfo = require("assets.explosion")
    private.myImageSheet = graphics.newImageSheet( "assets/explosion.png", private.sheetInfo:getSheet() )
    private.data = {
      {
        name = "move",
        sheet = private.sheetInfo,
        start = 1,
        count = 9,
        time = 800,
        loopCount = 0
      }
    }

    private.sprite = display.newSprite(private.group,private.myImageSheet, private.data)
    private.del = false

    private.sprite:setSequence("move")
    private.sprite:play()


    private.sprite:scale(0.7,0.7)
    private.sprite.x,private.sprite.y = private.x,private.y

    function public:update()
      private.count = private.count + 1
      if private.count > 50 then
        private.del = true
        private.group:removeSelf()
      end
    end

    function public:getDelete()
      return private.del
    end

    function public:getX()
      return private.sprite.x
    end

    function public:getY()
      return private.sprite.y
    end

    function public:getW()
      return private.sprite.contentWidth
    end

    function public:getH()
      return private.sprite.contentHeight
    end

    setmetatable(self,public)
    self.__index = self
    return public
  end


  return explosion
