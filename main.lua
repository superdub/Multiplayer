local composer = require "composer"
composer.recycleOnSceneChange = true
system.activate("multitouch")
math.randomseed(os.time())
composer.gotoScene("scenes.MainMenu")
