-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local oX = display.screenOriginX -- Centro X
local oY = display.screenOriginY -- Origem Y

-- Set up display groups
local backGroup = display.newGroup()

function scene:create( event )

	local sceneGroup = self.view

	local lives = 6
    local money = 0
    local jumpLimit = 0 
    local dead = false
    
    physics.start()  -- Temporarily pause the physics engine

    --Background

		local background = display.newImageRect( backGroup, "ui/telas/sky.png", display.actualContentWidth, display.actualContentHeight )
		background.x = cX 
		background.y = cY + display.screenOriginY

		local ground = display.newImageRect( backGroup, "ui/telas/street.png", display.actualContentWidth, 90)
	    ground.x = cX 
	    ground.y = display.contentHeight-35

	    local city1 = display.newImageRect( backGroup, "ui/telas/city1.png", 554, 130 )
	    city1.x = cX
	    city1.y = display.contentHeight-145
	    
	    local city2 = display.newImageRect( backGroup, "ui/telas/city2.png", 554, 130 )
	    city2.x = cX+554
	    city2.y = display.contentHeight-145

	    function scrollCity(self, event)
	    	if self.x < -535 then
	    		self.x = 554
	    	else
	    		self.x = self.x -2
	    	end
	    end

	    city1.enterFrame = scrollCity
	    Runtime:addEventListener( "enterFrame", city1 )

	    city2.enterFrame = scrollCity
	    Runtime:addEventListener( "enterFrame", city2 )

	    ground.enterFrame = scrollCity
	    Runtime:addEventListener( "enterFrame", ground )


		local credit = display.newImage("ui/background/credit.png", 130, 40)
		credit.x = cX-205
		credit.y = cY-130

		local debit = display.newImage("ui/background/debit.png", 130, 40)
		debit.x = cX-70
		debit.y = cY-130







	    -- Score
	    livesText = display.newText( "$ ".. lives, 50, 28, native.systemFont, 20)
	    livesText:setFillColor( 0, 0, 0 )
	    moneyText = display.newText( "$ ".. money, 190, 28, native.systemFont, 20)
	    moneyText:setFillColor( 0, 0, 0  )

	    -- Credits
	    local ten = display.newImageRect( "ui/elements/10.png", 50, 50 )
	    ten.x = cX
	    ten.y = cY+70
	    ten.speed = math.random(2,8)
	    ten.initY = ten.y
	    ten.amp   = math.random(20,100)
	    ten.angle = math.random(20,100)
	    ten.name = "ten"

	    local twenty = display.newImageRect( "ui/elements/20.png", 50, 50 )
	    twenty.x = cX
	    twenty.y = cY
	    twenty.speed = math.random(2,8)
	    twenty.initY = twenty.y
	    twenty.amp   = math.random(20,100)
	    twenty.angle = math.random(20,100)
	    twenty.name = "twenty"


	    -- Load the Sprite

		local sheetData = {
		    width=69;               --Largura Sprite
		    height=90;              --Altura Sprite
		    numFrames=10;            --Número de Frames
		    sheetContentWidth=345,  --Largura da Folha de Sprites
		    sheetContentHeight=180   --Altura da Folha de Sprites
		    -- 1 to 6 corre
		    -- 7 to 10 pula
		}

		local sequenceData = {
		    { name = "run", start=1, count=6, time=800},
		    { name = "jump", start=7, count=10, time=1000}
		}

		local mySheet = graphics.newImageSheet( "ui/sprite/sprite_boy2.png", sheetData )

		local animation = display.newSprite( mySheet, sequenceData )
		animation.x = cX-150
		animation.y = cY+100

		animation.timeScale = 1.0
		animation:setSequence( "run" )
		animation:play( )

		-- End the Sprite
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