  local button = {}

  function button:new(x,y,R)
    local public = {}
    local private = {}

    private.x = x or 0
    private.y = y or 0
    private.R = R or 1

    private.FlagEnded = false
    private.click = true
    private.beganClick = false
    private.group = display.newGroup()
    private.timer = 0
    private.button = display.newCircle(private.group,0,0,private.R)
    private.button.strokeWidth = private.R/10
    private.button:setFillColor(.3,.3,.3,.2)
    private.button:setStrokeColor(.4,.4,.4,.4)
    private.button.alpha = 0.4
    function private.button:touch(event)
        local phase = event.phase
        if phase == "ended" then
            private.timer = 0
            private.beganClick = false
            private.FlagEnded = true
        end
      if phase=="began" or ( phase=="moved" and self.isFocus ) then
          if phase == "began" then
            display.getCurrentStage():setFocus( event.target, event.id )
            self.eventID = event.id
            self.isFocus = true
            private.click = "true"
            private.button:setFillColor(.3,.3,.3,.4)
            private.button:setStrokeColor(.4,.4,.4,.6)
            private.button.alpha = 1
            private.timer = private.timer + 1
            private.beganClick = true
            private.FlagEnded = false
          end
          private.timer = private.timer + 1
          if private.timer >= 1 then
            private.click = "move"
          end
          if private.timer > 10000 then
            private.timer = 0
          end
          if phase == "moved" then
            private.click = "move"
          end
      else
        display.getCurrentStage():setFocus( nil, event.id )
        self.isFocus = false
        private.click = "false"
        private.timer = 0
        private.button:setFillColor(.3,.3,.3,.2)
        private.button:setStrokeColor(.4,.4,.4,.4)
        private.button.alpha = 0.4
      end
      return true
    end

    private.group:addEventListener("touch",private.button)

    function public:getClick()
      return private.click
    end

    function public:getGroup()
      return private.group
    end

    function public:getBegan()
      return private.beganClick
    end

    function public:getEnded()
      return private.FlagEnded
    end

    private.group.x = private.x
    private.group.y = private.y

    setmetatable( self, public )
    self.__index = self
    return public
  end



  return button
