  local composer = require "composer"
  local widget = require "widget"
  local W,H = display.contentWidth,display.contentHeight
  local scene = composer.newScene()


  --описание node js
  require("lib.noobhub")

  --создание объекта
  local hub = noobhub.new({server = "46.4.76.236"; port = 1337;})

  function scene:create(event)
    local sceneGroup = self.view
    --загрузка карты
    local map = require "modules.map"

    local playerName = composer.getVariable("textname")

    --загрузка джойстика
    local joystick = require "lib.joystick":new(W*0.1,H*0.81,W*0.1,W*0.05)


    --button стрельбы
    local button = require "lib.button":new(W*0.9,H*0.81,W*0.1)


    --создание игрока
    local player = require "modules.player":new(joystick,W*0.5,H*0.5,playerName,button)



    --подключение камеры
    local camera = require "lib.camera":new(joystick)
    camera:add(player:getPlayerGroup())


    --создание сервера и клиента
    local server = require "modules.server":new(playerIp,playerPort,player,0,hub)
    local client = require "modules.client":new(player,playerIp,playerPort,0,hub,player:getBullets())



  end


  scene:addEventListener("create",scene)
  return scene
