
-- Include modules/libraries
local composer = require( "composer")
local widget = require( "widget" )
--local sounds = require( "soundsfile" )

local level = require("leveltemplate")

-- Create a new Composer scene
local scene = composer.newScene()

local background
local alert

local function gotoMenu()
	composer.gotoScene( "game.menu.menu" )
end

function scene:create( event )

	local sceneGroup = self.view
	level:setValues(100,100,3)


	background = display.newImageRect( sceneGroup, "images/screens/imgLvl0.png", 580, 300 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	sceneGroup:insert( background )

	alert = display.newImageRect( sceneGroup, "images/events/gameOver.png", 304, 176 )
	alert.x = display.contentCenterX
	alert.y = display.contentCenterY
	sceneGroup:insert( alert )

	local backButton = display.newImageRect( sceneGroup, "images/buttons/menuBtn.png", 55, 55 )
	backButton.x = display.contentCenterX
	backButton.y = display.contentCenterY + 40
	sceneGroup:insert( backButton )

	backButton:addEventListener( "tap", gotoMenu )
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
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		display.remove(sceneGroup)
		print( "Removendo Botões" )
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