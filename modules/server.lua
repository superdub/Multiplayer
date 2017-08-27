  local server = {}
  local _M = require "modules.object"
  local W,H = display.contentWidth,display.contentHeight


  function server:new(ip,port,player,timeout,hub)
    local public = {}
    local private = {}

    private.hub = hub
    private.players = {}
    private.player = player
    private.bullets = require "modules.bullets":new(player:getName())
    private.bulNaId = {}
    private.deads = require "modules.dead":new()


    function private.Collision(x1,y1,w1,h1,x2,y2,w2,h2)
        return x1 < x2+w2 and
               x2 < x1+w1 and
               y1 < y2+h2 and
               y2 < y1+h1
      end

      --функции добавления пуль
    function private:addBulNaId(id,name)
      local flag = true
      local indexId,indexName
      if #self.bulNaId > 0 then
        for i,v in ipairs(self.bulNaId) do
          if v.name == name  and v.id == id then
            flag = false
          else

          end
        end
        if  flag then
          local bul = {id = id,name = name}
          table.insert(self.bulNaId,bul)
        end
      else
        local bul = {id = id,name = name}
          table.insert(self.bulNaId,bul)
        end
      end
    function private:addBullets(x,y,dir,name,id)
      local flag = true
        if #self.bullets:getMas() > 0 then
          for i,v in ipairs(self.bulNaId) do
            if v.name == name and v.id == id then
              flag = false
            end
          end
          if flag then
            local flag3 = true
            for i,v in ipairs(self.bulNaId) do
              if v.name == name and v.id == id then
                flag3 = false
              end
            end
            if flag3 then
              self.bullets:add(x,y,dir,name)
            end
          else
          end
        else
          local flag2 = true
          for i,v in ipairs(self.bulNaId) do
            if v.name == name and v.id == id then
              flag2 = false
            end
          end
          if flag2 then
            self.bullets:add(x,y,dir,name)
          end
        end
     end


     --функции добавления персонажей
    function private:addPlayers(players,data)
      local flag = true
      local index = nil
      for i,v in ipairs(players) do
        if v:getCount() > 400 then
           table.remove(players,i)
           v:delete()
           v:getPlayer():removeSelf()
        end
        if v:getName() == data.name   then
          flag = false
          index = i
          v:del()
        else
          v:inc()
      end
      end
      if flag and data.name ~= player:getName() then
      local player = _M:newObject(data.x,data.y,data.dir,data.name)
      table.insert(players,player)
      else
      if index ~= nil and  data.name ~= player:getName() then
        players[index]:setData(data.x,data.y,data.dir,data.name)
      end
         end
      end



    private.hub:subscribe({
      	channel = "players";
      	callback = function(message)

          for i,v in ipairs(private.bulNaId) do
            if v.del then
              table.remove(private.bulNaId,i)
            end
          end

          --получение иноформации о юнитах
          if  message ~= nil and message.id == 1  then

                local data = json.decode(message.action)
                private:addPlayers(private.players,data)

            --получение информации о пулях
          elseif message ~= nil and message.id == 2 then
                local data = json.decode(message.action)
                if data.name ~= private.player:getName() then

                private:addBullets(data.x,data.y,data.dir,data.name,data.id)
                private:addBulNaId(data.id,data.name)


            --коллизия юнитов
            for i,v in ipairs(private.bullets:getMas()) do
                if private.Collision(v:getX(),v:getY(),v:getImage().contentWidth,v:getImage().contentHeight,private.player:getX(),private.player:getY(),private.player:getPlayerGroup().contentWidth,private.player:getPlayerGroup().contentHeight) then
                    private.player:setPos(math.random(0,W),math.random(0,H))
                    private.deads:add(v:getX(),v:getY())
                end
            end
          end
          end
        end
      })


    setmetatable( self, public)
    self.__index = self
    return public
  end


  return server
