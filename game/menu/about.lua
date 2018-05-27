local composer 	= require("composer")
composer.recycleOnSceneChange = true
local physics 	= require("physics")
local widget 	= require("widget")
local sounds 	= require("sounds")
local base 		= require("base")
local scene 	= composer.newScene()

local cX 	= display.contentCenterX -- Coordenada X
local cY 	= display.contentCenterY -- Coordenada Y
local acW 	= display.actualContentWidth
local acH 	= display.actualContentHeight

local function backtoMenu()
	--playSFX(singsSounds)
	composer.gotoScene( "game.menu.menu" )
end

local backGroup = display.newGroup()
local mainGroup = display.newGroup()

function scene:create( event )
	
	local sceneGroup = self.view

		local background = display.newImageRect( backGroup,"images/about.png", acW, acH )
		background.x = cX 
		background.y = cY

	    local back = display.newImageRect(mainGroup, "images/buttons/back.png", 144, 44)
	    back.x = 410
	    back.y = 250

	    back:addEventListener( "tap", backtoMenu )
	    --audio.back( mu )
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
		print("About: Removendo background")
		display.remove(mainGroup)
		print("About: Removendo Botões")
		print("About: Retornando ao Menu")
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