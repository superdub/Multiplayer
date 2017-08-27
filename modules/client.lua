  local client = {}

  function client:new (player,ip,port,timeout,hub,bullets)
    local private = {}
    local public = {}

    private.player = player
    private.hub = hub
    private.bullets = bullets


    function private:send(x,y,name,dir,bullets)
      --отправка информации playera
      local data = {["name"] = name,["x"] = x,["y"] = y,["dir"] = dir}
      local jsondata = require "json".encode(data)
        private.hub:publish({
  		  message = {
  			action  =  jsondata,
  			id = 1,
  			timestamp = system.getTimer()
  		}
  	});

    --отправка информации о пулях
    for i,v in ipairs(self.bullets) do
      local data = {["x"] = v:getX(),["y"] = v:getY(),["name"] = v:getName(),["id"] = v:getId(),["dir"] = v:getDirection(),["del"] = v:getDelete()}
      local jsondata = require "json".encode(data)
      private.hub:publish({
        message = {
          action = jsondata,
          id = 2,
          timestamp = system.getTimer()
        }
      })
    end

    end

    function private:enterFrame (event)
      self:send(self.player:getX(),self.player:getY(),self.player:getName(),self.player:getDirection(),self.bullets)
    end

    Runtime:addEventListener("enterFrame",private)


    setmetatable( self, public )
    self.__index = self
    return public
  end

  return client
