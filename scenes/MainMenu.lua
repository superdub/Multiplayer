  local composer = require "composer"
  local widget = require "widget"
  local W,H = display.contentWidth,display.contentHeight
  local scene = composer.newScene()

  local butGame,butMultiGame,butExit



  function scene:create(event)

    local sceneGroup = self.view



    -- button one game
    butGame = widget.newButton({
      x = W*0.5,
      y = H*0.3,
      width = W*0.5,
      height = H*0.1,
      fillColor = { default={0.1,0.5,0.5,1}, over={0.1,0.7,0.7,0.4} },
      strokeColor = { default={0.9,0.9,0,9}, over={0.8,0.8,1,1} },
      strokeWidth = 1.3,
      labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
      shape = "roundedRect",
      label = "одиночная игра",
      onEvent = function()
        composer.gotoScene("scenes.Game",{
          effect = "fade",time = 400
        })
      end
    })
    sceneGroup:insert(butGame)



    --button online game
    butMultiGame = widget.newButton({
      x = W*0.5,
      y = H*0.5,
      width = W*0.5,
      height = H*0.1,
      fillColor = { default={0.1,0.5,0.5,1}, over={0.1,0.7,0.7,0.4} },
      strokeColor = { default={0.9,0.9,0,9}, over={0.8,0.8,1,1} },
      strokeWidth = 1.3,
      labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
      shape = "roundedRect",
      label = "local multiplayer",
      onEvent = function()
        composer.gotoScene("scenes.MultiGameMenu",{
          effect = "fade",time = 300
        })
      end
    })
    sceneGroup:insert(butMultiGame)


    --button exit
    butExit = widget.newButton({
      x = W*0.5,
      y = H*0.7,
      width = W*0.5,
      height = H*0.1,
      fillColor = { default={0.1,0.5,0.5,1}, over={0.1,0.7,0.7,0.4} },
      strokeColor = { default={0.9,0.9,0,9}, over={0.8,0.8,1,1} },
      strokeWidth = 1.3,
      labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
      shape = "roundedRect",
      label = "exit",
      onEvent = function()
        native.requestExit()
      end
    })
    sceneGroup:insert(butExit)


  end



  function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


  scene:addEventListener("create",scene)

  return scene
