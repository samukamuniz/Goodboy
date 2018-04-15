-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y

local function gotoGame()
    composer.gotoScene( "game", { time=800, effect="crossFade" } )
    --audio.play( mu )
end


function scene:create( event )
	
	local sceneGroup = self.view

		local background = display.newImageRect( "ui/menu/display.png", display.actualContentWidth, display.actualContentHeight )
		background.x = cX 
		background.y = cY

	    local play = display.newImageRect("ui/menu/play.png", 144, 44)
	    play.x = cX
	    play.y = cY-30

	    local levels = display.newImageRect("ui/menu/levels.png", 144, 44)
	    levels.x = cX 
	    levels.y = cY+20

	    local settings = display.newImageRect("ui/menu/settings.png", 144, 44)
	    settings.x = cX
	    settings.y = cY+70 

	    play:addEventListener( "tap", gotoGame )
	    --audio.play( mu )
		--levels:addEventListener( "tap", gotoCredits )
		--settings:addEventListener( "tap", gotosettings )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene