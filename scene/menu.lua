-- Include modules/libraries
local composer = require( "composer")
--local loadsave = require( "loadsave")

composer.recycleOnSceneChange = true

local physics = require("physics")
local widget = require( "widget" )
local sounds = require( "soundsfile" )
local base = require( "base")

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y

-- Create a new Composer scene
local scene = composer.newScene()

local function gotoGame()
	--playSFX(menupicksound)
	composer.gotoScene( "scene.level1" )
end

local function gotoLevels()
	--playSFX(menupicksound)
	composer.gotoScene( "scene.levels" )
end

local function openSettings()
	--playSFX(menupicksound)
	--composer.gotoScene( "scene.levels" )
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
		levels:addEventListener( "tap", gotoLevels )
		--settings:addEventListener( "tap", gotosettings )
end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then		
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene("menu")
		composer.hideOverlay()
	end
end


-- destroy()
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