-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )
physics.start()
--physics.setGravity( 0, 0 )

-- Seed the random number generator
math.randomseed( os.time() )

local moneysTable = {}

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local oX = display.screenOriginX -- Centro X
local oY = display.screenOriginY -- Origem Y
local h = display.contentHeight
local w = display.contentWidth


-- Set up display groups
local backGroup = display.newGroup()

function scene:create( event )

	local sceneGroup = self.view

	local lives = 3
    local money = 0
    local jumpLimit = 0 
    local dead = false
    local speedCity = 1
    local speedGround = 2
    local cloudCity = 0.5
    physics.start()  -- Temporarily pause the physics engine

    --Background
	local background = display.newImageRect("ui/telas/sky.png", display.actualContentWidth, display.actualContentHeight )
	background.x = w/2 
	background.y = cY + display.screenOriginY --ok


	-- Ground
	local gnd1 = display.newImageRect("ui/telas/street.png", 560, 90)
    gnd1.x = 0
    gnd1.y = 275
    gnd1.speed = speedGround
    
    local gnd2 = display.newImageRect("ui/telas/street.png", 560, 90)
    gnd2.x = 544 
    gnd2.y = 275
    gnd2.speed = speedGround

        --Shape
    local base = display.newRect( w/2, h-15, 600, 25 )
    base:setFillColor( 0.5 )
    physics.addBody( base, "static", {bounce = 0})

    -- Cloud
    local cloud1 = display.newImageRect("ui/telas/cloud1.png", 554, 50 )
    cloud1.x = 0
    cloud1.y = h/5
    cloud1.speed = cloudCity

    local cloud2 = display.newImageRect("ui/telas/cloud2.png", 554, 50 )
    cloud2.x = 544
    cloud2.y = h/5
    cloud2.speed = cloudCity

    -- City
    local city1 = display.newImageRect("ui/telas/city1.png", 554, 130 )
    city1.x = cX
    city1.y = h-148
    city1.speed = speedCity
    
    local city2 = display.newImageRect("ui/telas/city2.png", 554, 130 )
    city2.x = cX+554
    city2.y = h-145
    city2.speed = speedCity

    -- Elementos contadores

    --[[ Credit and Debit
	local credit = display.newImage("ui/background/credit.png", 130, 40)
	credit.x = cX-205
	credit.y = cY-130

	local debit = display.newImage("ui/background/debit.png", 130, 40)
	debit.x = cX-70
	debit.y = cY-130
    ]]
    -- Function for move all elements on Display

    local function moveX( self, event )
    	if (self.x < -272) then
    		self.x = 806
    	else
    		self.x = self.x - self.speed
    	end
    end

    --Chamando a função para mover os elementos

    gnd1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", gnd1)
    gnd2.enterFrame = moveX
    Runtime:addEventListener("enterFrame", gnd2)
    city1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city1)
    city2.enterFrame = moveX
    Runtime:addEventListener("enterFrame", city2)
    cloud1.enterFrame = moveX
    Runtime:addEventListener("enterFrame", cloud1)
    cloud2.enterFrame = moveX
    Runtime:addEventListener("enterFrame", cloud2)

    -- Score
    livesText = display.newText( "$ ".. lives, 50, 29, "RifficFree-Bold.ttf", 20)
    livesText:setFillColor( 0, 255, 0 )
    moneyText = display.newText( "$ ".. money, 190, 29, "RifficFree-Bold.ttf", 20)
    moneyText:setFillColor( 255, 0, 0  )

    --#SPRITES
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

    -- Declarando o dinheiro
    --[[
    local ten = display.newImageRect("ui/elements/ten.png", 50, 50)
    ten.x = 554
    ten.y = 180
    ten.myName = "ten"
    physics.addBody( ten, "kinematic", {density=1.0, friction=0.5, bounce=0.3, isSensor=true, radius=50 } )
    ten:setLinearVelocity(-150,0)
]]
	local playBoy = display.newSprite( mySheet, sequenceData)
	playBoy.x = cX-150
	playBoy.y = cY+100
    playBoy.myName = "playBoy"
    physics.addBody( playBoy, "dynamic", { density = 0, friction = 0, bounce = 0.3, gravity = 0,
                                        radius=40, isSensor=false } )
    playBoy:setSequence( "run" )
    playBoy:play( )

    -- 23/04/2018 (Adicionando)
    local function createMoney()
        local newTen = display.newImageRect("ui/elements/ten.png", 50, 50)
        table.insert(moneysTable, newTen)
        physics.addBody( newTen, "kinematic", { density = 0, friction = 0, bounce = 0, gravity = 0,
                                        radius=50, isSensor=true } )
        newTen.myName = "moneyTen"

        local newTwenty = display.newImageRect("ui/elements/twenty.png", 50, 50)
        table.insert(moneysTable, newTwenty)
        physics.addBody( newTwenty, "kinematic", { density = 0, friction = 0, bounce = 0, gravity = 0,
                                        radius=50, isSensor=true } )
        newTwenty.myName = "moneyTwenty"

        local newFifty = display.newImageRect("ui/elements/fifty.png", 50, 50)
        table.insert(moneysTable, newFifty)
        physics.addBody( newFifty, "kinematic", { density = 0, friction = 0, bounce = 0, gravity = 0,
                                        radius=50, isSensor=true } )
        newFifty.myName = "moneyFifty"


        local whereFrom = math.random( 1,3 )
            if ( whereFrom == 1 ) then
                -- From the left
                newTen.x = 600
                newTen.y = 130
                newTen:setLinearVelocity( -100, 0 )
            elseif ( whereFrom == 2 ) then
                -- From the top
                newTwenty.x = 600
                newTwenty.y = 130
                newTwenty:setLinearVelocity( -100, 0 )
            elseif ( whereFrom == 3 ) then
                -- From the right
                newFifty.x = 600
                newFifty.y = 100
                newFifty:setLinearVelocity( -100, 0 )
            end
        --newMoney:applyTorque( math.random( -6,6 ) )
    end

    local function gameLoop()
     -- Create new money
    createMoney()
        -- Remove asteroids which have drifted off screen
        for i = #moneysTable, 1, -1 do
            local thisMoney = moneysTable[i]
     
            if ( thisMoney.x < -554 or
                 thisMoney.x > display.contentWidth + 100 or
                 thisMoney.y < -100 or
                 thisMoney.y > display.contentHeight + 100 )
            then
                display.remove( thisMoney )
                table.remove( moneysTable, i )
            end
        end
    end


    gameLoopTimer = timer.performWithDelay( 1000, gameLoop, 0.4  )

    -- Função de Pulo
    local function onTouch(event)
    if(event.phase == "began") then
        jumpLimit = jumpLimit + 1
        if jumpLimit < 2 then
          physics.addBody(playBoy, "dynamic", { density = 0.015, friction = 0, bounce = 0.055, gravity = 0 })
          playBoy:applyLinearImpulse(0, 1, playBoy.x, playBoy.y)
          playBoy:setSequence( "jump" )
        end
        playBoy:setSequence( "run" )
     jumpLimit = 1
    end
    end
    Runtime:addEventListener("touch", onTouch)
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
