  local animation = {}

  function animation:new(sprites,joystick)
    local public = {}
    local private = {}

    private.sprites = sprites
    public.player = private.sprites.down
    public.dir = "pause"
    private.joystick = joystick

    function private:fIsVisible(anim)
      for k,v in pairs(self.sprites) do
        if k ~= anim then
          v.isVisible = false
        end
      end
    end


    function private:changeAnim(anim)
      if anim == "up" then
        public.player = self.sprites.up
        self.sprites.up.isVisible = true
        self:fIsVisible("up")
        public.player:play()
        public.dir = "up"
      elseif anim == "left" then
        public.player = sprites.left
        self.sprites.left.isVisible = true
        self:fIsVisible("left")
        public.player:play()
        public.dir = "left"
      elseif anim == "down" then
        public.player = sprites.down
        self.sprites.down.isVisible = true
        self:fIsVisible("down")
        public.player:play()
        public.dir = "down"
      elseif anim == "up_d" then
        public.player = sprites.up_d
        self.sprites.up_d.isVisible = true
        self:fIsVisible("up_d")
        public.player:play()
        public.dir = "up_d"
      elseif anim == "down_l" then
        public.player = sprites.down_l
        self.sprites.down_l.isVisible = true
        self:fIsVisible("down_l")
        public.player:play()
        public.dir = "down_l"
      elseif anim == "down_d" then
        public.player = sprites.down_d
        self.sprites.down_d.isVisible = true
        self:fIsVisible("down_d")
        public.player:play()
        public.dir = "down_d"
      elseif anim == "side" then
        public.player = sprites.side
        self.sprites.side.isVisible = true
        self:fIsVisible("side")
        public.player:play()
        public.dir = "side"
      elseif anim == "up_l" then
        public.player = sprites.up_l
        self.sprites.up_l.isVisible = true
        self:fIsVisible("up_l")
        public.player:play()
        public.dir = "up_l"
      elseif anim == "pause" then
        public.player = sprites.down
        self.sprites.down.isVisible = true
        self:fIsVisible("down")
        public.player:pause()
        public.dir = "down"
      end
    end


    function public:setAnim(angle)
      if angle ~= nil then
        angle = tonumber(angle)
       if angle > 1.2 and angle <= 2 then
        private:changeAnim("up",private.sprites)
       end
       if angle > 0.6 and angle <= 1.2 then
        private:changeAnim("up_l",private.sprites)
       end
       if angle <= 0.6 and angle > 0  then
        private:changeAnim("left",private.sprites)
       end
       if angle ==  0 then
         self.player = private.sprites.down
         private.sprites.down.isVisible = true
         private.sprites.down:pause()
         private:changeAnim("down",private.sprites)
         self.player:pause()
       end
       if angle < 0 and angle >= -1  then
          private:changeAnim("down_l",private.sprites)
       end
       if angle < -1 and angle >= -2 then
          private:changeAnim("down",private.sprites)
       end
       if angle < -2 and angle >= -2.5 then
           private:changeAnim("down_d",private.sprites)
       end
       if angle < -2.5 and angle >= -3 or angle > 2.5 and angle <= 3 then
         private:changeAnim("side",private.sprites)
       end
       if angle > 2 and angle < 2.5 then
         private:changeAnim("up_d",private.sprites)
       end
     end
    end

    function public:changeAnim(anim)
      private:changeAnim(anim)
    end


    setmetatable(self,public)
    self.__index = self
    return public
  end

  return animation
