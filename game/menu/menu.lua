-- Include modules/libraries
local composer 	= require("composer")
--local loadsave = require( "loadsave")

composer.recycleOnSceneChange = true

local physics 	= require("physics")
local widget 	= require("widget")
local sounds 	= require("sounds")
local scene 	= composer.newScene()

local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local acW = display.actualContentWidth
local acH = display.actualContentHeight

local function gotoGame()
	--playSFX(singsSounds)
	composer.gotoScene("game.levels.level1")
end

local function gotoLevels()
	--playSFX(singsSounds)
	composer.gotoScene("game.menu.levels")
end

local function gotoScores()
	--playSFX(singsSounds)
	composer.gotoScene("game.menu.rScores")
end

local function gotoAbout()
	--playSFX(singsSounds)
	composer.gotoScene("game.menu.about")
end

local backGroup = display.newGroup()
local mainGroup = display.newGroup()

function scene:create( event )
	
	local sceneGroup = self.view

		local background = display.newImageRect( backGroup,"images/screens/display.png", acW, acH )
		background.x = cX 
		background.y = cY

	    local play = display.newImageRect(mainGroup, "images/buttons/play.png", 144, 44)
	    play.x = cX-80
	    play.y = cY

	    local levels = display.newImageRect(mainGroup, "images/buttons/levels.png", 144, 44)
	    levels.x = cX+80
	    levels.y = cY

	    local rules = display.newImageRect(mainGroup, "images/buttons/rules.png", 144, 44)
	    rules.x = cX-80
	    rules.y = cY+70 
	    --playSFX(singsSounds)

	    local about = display.newImageRect(mainGroup, "images/buttons/about.png", 144, 44)
	    about.x = cX+80
	    about.y = cY+70 
	    --playSFX(singsSounds)

	    play:addEventListener( "tap", gotoGame )
	    --audio.play( mu )
		levels:addEventListener( "tap", gotoLevels )
		about:addEventListener( "tap", gotoAbout )
		rules:addEventListener( "tap", gotoScores )
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

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene("menu")
		display.remove(backGroup)
		print("Menu: Removendo background")
		display.remove(mainGroup)
		print("Menu: Removendo Botões")
		composer.hideOverlay()
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene