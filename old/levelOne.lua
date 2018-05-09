
local composer = require("composer") 	 	--Importa o Composer
local physics = require("physics") 		 	--Importa a Fisica
--local sounds = require( "soundsfile" )	 	--Importa o Som
local level = require("leveltemplate")		--Importa o aqruivo leveltemplate.lua

local scene = composer.newScene()			-- Cria uma nova cena pelo Composer

composer.recycleOnSceneChange = true		-- Não sei o que faz

local backGroup = display.newGroup()		-- bg1 Cria um grupo para o Background
local mainGroup = display.newGroup()		-- Cria um grupo para o .....
local uiGroup = display.newGroup()			-- Cria um grupo para o .....
local jumpLimit = 0							-- Variável para Limite de pulo


--- SCENE EVENT FUNCTIONS

function scene:create( event )
	local sceneGroup = self.view
	level:setCurrentLevel(1)				--Seta o nível atual
	--playGameMusic(babybgmusic)			--Importa do arquivo soundsfile.lua a musica 
	--audio.setVolume( 0.50, { channel=1 } ) 

	--CRIA O BACKGROUND
	background = level:createBackground(level:getCurrentLevel()) --Adc o background relativo ao level
	backGroup:insert(background)	-- coloca o backround no backgroup bg1
end


function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --physics.start()
         --audio.play( musicTrack, { channel=1, loops=-1 } )
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
		physics.pause()
        composer.removeScene( "game" )
		composer.hideOverlay()
		--Runtime:removeEventListener( "collision", onCollision)
		--Runtime:removeEventListener("touch", onTouch)
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