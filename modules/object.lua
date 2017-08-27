local _M = {}

function _M:newObject(x,y,dir,name)
  local public = {}
  local private = {}

  private.delete = false
  private.x,private.y,private.dir,private.name = x or 100,y or 100,dir or "pause",name
  private.group = display.newGroup()
  private.count = 0
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
    side =  graphics.newImageSheet( "assets/Animside.png", private.options.move),
    left =  graphics.newImageSheet( "assets/Animleft.png", private.options.move),
    up_l =  graphics.newImageSheet( "assets/AnimupL.png", private.options.move),
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
    down_d = display.newSprite(private.group, private.imageSheets.down_d, private.sequences_player ),
    down_l = display.newSprite(private.group, private.imageSheets.down_l, private.sequences_player ),
    down = display.newSprite(private.group, private.imageSheets.down, private.sequences_player ),
    up_l = display.newSprite(private.group, private.imageSheets.up_l, private.sequences_player ),
  }

  private.text = display.newText(private.group,private.name,private.group.x,private.group.y - private.sprites.down.contentHeight*0.9,native.systemFont, 10)
  private.text:setFillColor(0.9,0.9,0.9,1)


  private.animation = require "modules.animation":new(private.sprites)




  function private:enterFrame(event)
    if not self.delete and self.dir ~= nil then
      private.animation:changeAnim(self.dir)
    end
  end



  private.group.x = private.x
  private.group.y = private.y

  Runtime:addEventListener("enterFrame",private)

  private.group:scale(.8,.8)

  function public:setData(x,y,dir,name)
    private.group.x = x
    private.group.y = y
    private.dir = dir
    private.name = name
  end

  function public:getName()
    return private.name
  end

  function public:getCount()
    return private.count
  end

  function public:getPlayer()
    return private.group
  end

  function public:inc()
    private.count = private.count + 1
  end

  function public:del()
    private.count = 0
  end

  function public:delete()
    private.delete = true
  end

  setmetatable( self, public )
  self.__index = self
  return public
end


return _M
