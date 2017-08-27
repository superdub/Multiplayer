local player = {}
local W,H = display.contentWidth,display.contentHeight

function player:new(joystick,x,y,name,shot)
  local public = {}
  local private = {}

  private.x = x or 0
  private.y = y or 0
  private.joystick = joystick
  private.name = name or "player"
  private.group = display.newGroup()
  private.shot = shot
  private.bullets = require "modules.bullets":new()




  private.options =
  {
    move = {
      width = 17,
      height = 20,
      numFrames = 4,
      sheetContentWidth = 17,
      sheetContentHeight = 80
    }
 }


  private.imageSheets =
  {
    down = graphics.newImageSheet( "assets/Animdown.png", private.options.move),
    down_d =  graphics.newImageSheet( "assets/AnimdownD.png", private.options.move),
    down_l =  graphics.newImageSheet( "assets/AnimdownL.png", private.options.move),
    up =  graphics.newImageSheet( "assets/Animup.png", private.options.move),
    up_d =  graphics.newImageSheet( "assets/AnimupD.png", private.options.move),
    up_l =  graphics.newImageSheet( "assets/AnimupL.png", private.options.move),
    side =  graphics.newImageSheet( "assets/Animside.png", private.options.move),
    left =  graphics.newImageSheet( "assets/Animleft.png", private.options.move),
  }


  private.sequences_player =
  {
     {
         name = "anim",
         frames = { 1,3,2,4 },
         time = 600
     },
     {
         name = "stand",
         frames = { 4 },
         time = 600
     }
 }



   private.sprites =
  {
    up = display.newSprite(private.group, private.imageSheets.up, private.sequences_player ),
    side = display.newSprite(private.group, private.imageSheets.side, private.sequences_player ),
    left = display.newSprite(private.group, private.imageSheets.left, private.sequences_player ),
    up_d = display.newSprite(private.group, private.imageSheets.up_d, private.sequences_player ),
    up_l = display.newSprite(private.group, private.imageSheets.up_l, private.sequences_player ),
    down_d = display.newSprite(private.group, private.imageSheets.down_d, private.sequences_player ),
    down_l = display.newSprite(private.group, private.imageSheets.down_l, private.sequences_player ),
    down = display.newSprite(private.group, private.imageSheets.down, private.sequences_player )
  }


  private.text = display.newText(private.group,private.name,private.group.x,private.group.y - private.sprites.down.contentHeight*0.9,native.systemFont, 10)
  private.text:setFillColor(0.9,0.9,0.9,1)


  private.animation = require "modules.animation":new(private.sprites)


  private.flagBeganShot = true
  private.timer = 0

  function private:enterFrame(event)
    local angle = self.joystick:getRotation()

    self.animation:setAnim(angle)

    if angle ~= nil then
     if not self.joystick:getClick() then
       self.animation.player:pause()
       self.animation.dir  = "pause"
     end


     --перемещение через границы
   if self.group.y < 0 then
     self.group:translate(0,H)
   end
   if self.group.y > H then
     self.group:translate(0,-H)
   end
    print(self.group.x,self.group.y)
   if self.group.x < -W*0.1 then
     self.group:translate(W*1.2,0)
   end
   if self.group.x > W*1.1 then
     self.group:translate(-W*1.2,0)
   end



   --функции стрельбы
   if self.shot:getEnded() then
      private.flagBeganShot = true
   end


   if self.shot:getBegan() and private.flagBeganShot  then

     self.bullets:add(self.group.x,self.group.y,private.animation.dir,self.name)
     private.flagBeganShot = false
   end



   if self.shot:getClick() == "move" then
     self.timer = self.timer + 1
     if self.timer % 20 == 0 then
        self.bullets:add(self.group.x,self.group.y,private.animation.dir,self.name)
        private.timer = 0
     end
   end

end
  end

  Runtime:addEventListener("enterFrame",private)



  private.group.x = private.x
  private.group.y = private.y
  private.group:scale(.8,.8)


  function public:getPlayerGroup()
    return private.group
  end

  function public:getPlayer()
    return private.animation.player
  end

  function public:getPos()
    return private.group.x,private.group.y
  end

  function public:getX()
    return private.group.x
  end

  function public:getJoistick()
    return private.joystick
  end

  function public:getY()
    return private.group.y
  end

  function public:getName()
    return private.name
  end

  function public:getDirection()
    return private.animation.dir
  end

  function public:getBullets()
    return private.bullets:getMas()
  end

  function public:getObjectBullets()
    return private.bullets
  end

  function public:setPos(x,y)
    private.group.x,private.group.y = x,y
  end

  setmetatable( self, public )
  self.__index = self
  return public
end


return player
