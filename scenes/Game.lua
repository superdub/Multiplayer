  local composer = require "composer"
  local widget = require "widget"
  local W,H = display.contentWidth,display.contentHeight
  local scene = composer.newScene()



  function scene:create(event)
    local sceneGroup = self.view

    --загрузка карты
    local map = require "modules.map"
    sceneGroup:insert(map.group)

    --загрузка джойстика
    local joystick = require "lib.joystick":new(W*0.1,H*0.81,W*0.1,W*0.05)
    sceneGroup:insert(joystick:getGroup())

    --button стрельбы
    local button = require "lib.button":new(W*0.9,H*0.81,W*0.1)
    sceneGroup:insert(button:getGroup())

    --создание игрока
    local player = require "modules.player":new(joystick,W*0.5,H*0.5,"player",button)
    sceneGroup:insert(player:getPlayerGroup())


    --подключение камеры
    local camera = require "lib.camera":new(joystick)
    camera:add(player:getPlayerGroup())


  end



  scene:addEventListener("create",scene)
  return scene
