  local Joystick = {}

  function Joystick:new(x,y,Or,Jr)
  local public = {}
  local private = {}

  private.stage = display.getCurrentStage()


  --группа для стика и джойстика
  private.group = display.newGroup()
  private.x = x or 0
  private.y = y or 0


  --радиусы
  private.outCircleR = Or or display.actualContentWidth*0.08
  private.joystickR = Jr or  display.actualContentHeight*0.06

  --создание джойстика
  private.outCircle = display.newCircle(private.group,0,0,private.outCircleR)
  private.outCircle.strokeWidth = private.outCircleR/10
  private.outCircle:setFillColor(0.2,0.2,0.2,0.3)
  private.outCircle:setStrokeColor(0.8,0.8,0.8,.3)

  --создание стика
  private.joystick = display.newCircle(private.group,0,0,private.joystickR)
  private.joystick.strokeWidth = private.joystickR/10
  private.joystick:setFillColor(0.7,0.7,0.7,.3)
  private.joystick:setStrokeColor(1,1,1,.3)

  --угол
  private.angle = 0

  --клик
  private.click = false

  private.group.x = private.x
  private.group.y = private.y

  function private.joystick:touch(event)
      local phase = event.phase
    if phase=="began" or ( phase=="moved" and self.isFocus ) then
        if phase == "began" then
          private.stage:setFocus( event.target, event.id )
          self.eventID = event.id
          self.isFocus = true
          private.click = true
          self.alpha = .9
          private.joystick:setStrokeColor(1,1,1,.9)
          private.outCircle.alpha = .9
          private.outCircle:setStrokeColor(0.8,0.8,0.8,.9)
        end


    --исправление бага
      if self.alpha <= .5 then
        self.alpha = .9
        private.joystick:setStrokeColor(1,1,1,.9)
        private.outCircle.alpha = .9
        private.outCircle:setStrokeColor(0.8,0.8,0.8,.9)
      end


      local parent = self.parent
      local posX, posY = parent:contentToLocal( event.x, event.y )
      private.angle = -math.atan2( posY, posX )
      local distance = math.sqrt( (posX*posX) + (posY*posY) )

      if ( distance >= private.outCircleR ) then
        distance = private.outCircleR
        self.x = distance * math.cos(private.angle)
        self.y = -distance * math.sin(private.angle)
      else
        self.x = posX
        self.y = posY
      end

    else
      transition.to( self,
      {x = 0,y = 0,time = (private.outCircleR + private.joystickR)*4,
      transition = easing.inOutQuad,onComplete = function()
        self.alpha = .5
        self:setStrokeColor(1,1,1,.3);
        private.outCircle.alpha = .5
        private.outCircle:setStrokeColor(0.8,0.8,0.8,.5);
        end})
      private.stage:setFocus( nil, event.id )
      self.isFocus = false
      private.click = false
    end
    return true
  end

  function public:getX()
    return private.joystick.x
  end

  function public:getY()
    return private.joystick.y
  end

  function public:getClick()
    return private.click
  end

  function public:getRotation()
    if private.outCircle.y ~= nil and private.joystick.y ~= nil then
     local angle = math.atan2(private.outCircle.y - private.joystick.y,private.outCircle.x - private.joystick.x)
     return angle
   end
  end

  function public:getGroup()
    return private.group
  end

  private.group:addEventListener( "touch", private.joystick )

  setmetatable( self, public )
  self.__index = self
  return public
  end





  return Joystick
