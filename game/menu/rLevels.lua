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

local function gotoRulesScores()
	composer.gotoScene( "game.menu.rScores" )
end

local function gotoMenu()
	composer.gotoScene( "game.menu.menu" )
end

local backGroup = display.newGroup()
local mainGroup = display.newGroup()

function scene:create( event )
	
	local sceneGroup = self.view

		local screen = display.newImageRect( backGroup,"images/screens/rulesLevels.png", acW, acH )
		screen.x = cX 
		screen.y = cY

	    local buttonAction = display.newImageRect(mainGroup, "images/buttons/leftBtn.png", 56, 56)
	    buttonAction.x = cX-50
	    buttonAction.y = 290
	    
	    local menuBtn = display.newImageRect(mainGroup, "images/buttons/menuBtn.png", 56, 56)
	    menuBtn.x = cX+50
	    menuBtn.y = 290

		menuBtn:addEventListener( "tap", gotoMenu )
	    buttonAction:addEventListener( "tap", gotoRulesScores )
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
		print("Levels_Rules: Removendo background")
		display.remove(mainGroup)
		print("Levels_Rules: Removendo Botões")
		print("Levels_Rules: Retornando ao Menu")
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