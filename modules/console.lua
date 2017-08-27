  local console = {}
  local W,H = display.contentWidth,display.contentHeight


  function console:new()
    local public = {}
    local private = {}


    private.mas = {
        display.newText("ddd",W*0.95,H*0.80,native.systemFont, 16),
        display.newText("ddd",W*0.95,H*0.85,native.systemFont, 16),
        display.newText("ddd",W*0.95,H*0.90,native.systemFont, 16),
    }

    function public:add(text)
       if private.mas[1].text ~= "" or private.mas[1].text ~= nil then
         private.mas[1].text = text
       elseif private.mas[2].text ~= "" or private.mas[2].text ~= nil then
         private.mas[2].text = text
       elseif private.mas[3].text ~= "" or private.mas[3].text ~= nil then
         private.mas[3].text = text
       end
    end

    function private:enterFrame(event)
       if private.mas[1].text ~= "" or private.mas[1].text ~= nil then
          transition.fadeOut( private.mas[1], {time = 1000,onComplete = function() private.mas[1].text = "dd" private.mas[1]:setFillColor(1,1,1,1)  end})
       end
       if private.mas[2].text ~= "" or private.mas[2].text ~= nil then
          transition.fadeOut( private.mas[2], {time = 1000,onComplete = function() private.mas[2].text = "dd" private.mas[2]:setFillColor(1,1,1,1)  end})
       end
       if private.mas[3].text ~= "" or private.mas[3].text ~= nil then
          transition.fadeOut( private.mas[3], {time = 1000,onComplete = function() private.mas[3].text = "dd" private.mas[3]:setFillColor(1,1,1,1)  end})
       end
    end

    Runtime:addEventListener("enterFrame",private)

    setmetatable(self,public)
    self.__index = self
    return public
  end

  return console
