  local composer = require "composer"
  local widget = require "widget"
  local W,H = display.contentWidth,display.contentHeight
  local scene = composer.newScene()

  local butHost,butBackMenu
  local textBox,label,textname


  function scene:create(event)

    local sceneGroup = self.view



    --**************************************************************************
    --лабел ввода name
    label = widget.newButton( {
      x = W*0.5,
      y = H*0.3,
      width = W*0.3,
      height = H*0.06,
      shape = "rect",
      label = "введите nikName",
      fillColor = { default={0.1,0.5,0.5,1}, over={0.1,0.7,0.7,0.4} },
    } )
    label:setEnabled( false )
     function textListener( event )
      if ( event.phase == "editing" ) then
         textname = event.text
      end
    end

    sceneGroup:insert(label)




        --**************************************************************************
    --нативный текстбох для вода имени
    textBox = native.newTextField( W*0.5, H*0.4, W*0.5,H*0.1 )
    textBox:addEventListener( "userInput", textListener )
    textBox.placeholder  = "nikname"
    sceneGroup:insert(textBox)


        --**************************************************************************
    --баттон подключения к серверу
    butHost = widget.newButton({
      x = W*0.5,
      y = H*0.7,
      width = W*0.5,
      height = H*0.1,
      fillColor = { default={0.1,0.5,0.5,1}, over={0.1,0.7,0.7,0.4} },
      strokeColor = { default={0.9,0.9,0,9}, over={0.8,0.8,1,1} },
      strokeWidth = 1.3,
      labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
      shape = "roundedRect",
      label = "подключится к серверу",
      onEvent = function()
        if textname ~= "" and textname ~= nil  then
        composer.setVariable( "textname", textname )
        textBox:removeEventListener( "userInput", textListener )
        composer.gotoScene("scenes.MultiGame",{
          effect = "fade",time = 50
        })
        end
      end
    })
    sceneGroup:insert(butHost)




        --**************************************************************************
    --баттон возврата в меню
    butBackMenu = widget.newButton({
      x = W*0.5,
      y = H*0.9,
      width = W*0.5,
      height = H*0.1,
      fillColor = { default={0.1,0.5,0.5,1}, over={0.1,0.7,0.7,0.4} },
      strokeColor = { default={0.9,0.9,0,9}, over={0.8,0.8,1,1} },
      strokeWidth = 1.3,
      labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
      shape = "roundedRect",
      label = "назад",
      onEvent = function()
        composer.gotoScene("scenes.MainMenu")
      end
    })
    sceneGroup:insert(butBackMenu)

  end


  scene:addEventListener("create",scene)

  return scene
