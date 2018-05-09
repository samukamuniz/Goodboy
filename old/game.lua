
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local oX = display.screenOriginX -- Centro X
local oY = display.screenOriginY -- Origem Y
local h = display.contentHeight
local w = display.contentWidth
local acw = display.actualContentWidth
local ach = display.actualContentHeight

local lives = 3
local died = false
local credit = 0
local debit = 0

local incomes = {}
local invoices = {}

local playerT
local gameLoopTimer
local livesText
local debitText
local creditText

--Criando Agrupamentos
local backGroup = display.newGroup()        -- Agrupa elementos de Background
local mainGroup = display.newGroup()        -- Agrupa elementos .....
local uiGroup = display.newGroup()          -- Agrupa elementos de Texto

local jumpLimit = 0 
local speedCity = 1
local speedGround = 2
local cloudCity = 0.5
local sequence = "running"


function createPlayer(playerSheet, sequence)

    local sheetData = {
        width=69;               --Largura Sprite
        height=90;              --Altura Sprite
        numFrames=10;            --Número de Frames
        sheetContentWidth=345,  --Largura da Folha de Sprites
        sheetContentHeight=180   --Altura da Folha de Sprites
    }

    local sheet_player
    local player

    if(sequence == "running") then
        local sequencesPlayer = {{
            name = "running",
            start = 1,
            count = 6,
            time = 800,
            --loopCount = 0,
            --loopDirection = "forward"
        }}

        sheet_player = graphics.newImageSheet("ui/sprite/sprite_boy2.png", sheetData) 
        player = display.newSprite(sheet_player, sequencesPlayer)       
    else
        local sequencesPlayer = {{
            name = "jumping",
            start = 7,
            count = 10,
            time = 1000,
            --loopCount = 0,
            --loopDirection = "forward"
        }}
        sheet_player = graphics.newImageSheet("ui/sprite/sprite_boy2.png", sheetData)
        player = display.newSprite(sheet_player, sequencesPlayer)           
    end
    player.name = 'Jogador'
    player.x = 130
    player.y = 250
    player:setSequence("running")
    player:play()   

    playerT = player
    return player
end


local function updateText()
    creditText.text = credit
    debitText.text = debit
end  

local function createIncomes()
    local xVal = math.random(600, 660)
    local yVal = math.random(100, 250)
    local yVel = -125
    local numIncome = 1--math.random( 0, 4)

    local ten = display.newImageRect( mainGroup, "ui/elements/ten.png", 50, 50)
    ten.x = xVal
    ten.y = yVal
    table.insert( incomes, ten )
    physics.addBody(ten, "dynamic",  { radius=50, bounce=0.8 })
    ten.myName = "moneyTen"

    --[[local twenty = display.newImageRect( mainGroup, "ui/elements/twenty.png", 50, 50)
    twenty.x = xVal
    twenty.y = yVal
    table.insert( incomes, twenty )
    twenty.myName = "moneyTwenty"
    physics.addBody(twenty, "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
    
    local fifty = display.newImageRect( mainGroup, "ui/elements/fifty.png", 50, 50)
    fifty.x = xVal
    fifty.y = yVal
    table.insert( incomes, fifty )
    fifty.myName = "moneyFifty"
    physics.addBody(fifty, "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
    
    local oneHundred = display.newImageRect( mainGroup, "ui/elements/oneHundred.png", 50, 50)
    oneHundred.x = xVal
    oneHundred.y = yVal
    table.insert( incomes, oneHundred )
    oneHundred.myName = "moneyOneHundred"
    physics.addBody(oneHundred, "kinematic",  { isSensor = true, gravity = 0, density=0.0 })]]  

    if (numIncome == 1) then
        ten:setLinearVelocity( yVel, 0 )
    elseif (numIncome == 2) then
        twenty:setLinearVelocity( yVel, 0 )
    elseif (numIncome == 3) then
        fifty:setLinearVelocity( yVel, 0 )
    elseif (numIncome == 4) then
        oneHundred:setLinearVelocity( yVel, 0 )
    end    
end

local function gameLoop()
 -- Create new money
createIncomes()
-- Remove asteroids which have drifted off screen
for i = #incomes, 1, -1 do
    local thisMoney = incomes[i]

    if (thisMoney.x < -554 or
        thisMoney.x > display.contentWidth + 100 or
        thisMoney.y < -100 or 
        thisMoney.y > display.contentHeight + 100 )
    then
        display.remove( thisMoney )
        table.remove( incomes, i )
    end
end
end

local function onCollision( event )

if ( event.phase == "began" ) then

    local obj1 = event.object1
    local obj2 = event.object2

    if ( ( obj1.myName == "moneyTen" and obj2.myName == "player" ) or
       ( obj1.myName == "player" and obj2.myName == "moneyTen" ) )
    then
        
    display.remove( obj1 )
    display.remove( obj2 )

    for i = #incomes, 1, -1 do
        if ( incomes[i] == obj1 or incomes[i] == obj2 ) then
            table.remove( incomes, i )
            break
        end
    end
    
    
    -- Increase pontos
    credit = credit + 10
    creditText.text = "Credit: " .. credit

    end

end
end

-- Function for move all elements on Display
local function moveX( self, event )
    if (self.x < -275) then
        self.x = 806
    else
        self.x = self.x - self.speed
    end
end

gameLoopTimer = timer.performWithDelay( 800, gameLoop, -1)

--[[Função de Pulo
local function onTouch(event)
if(event.phase == "began") then
    jumpLimit = jumpLimit + 1
    if jumpLimit < 2 then
      physics.addBody(playerT, "dynamic", { density = 0.015, friction = 0, bounce = 0.055, gravity = 0 })
      playerT:applyLinearImpulse(0, 1, playerT.x, playerT.y)
      playerT:setSequence( "running" )
    end
    playerT:setSequence( "run" )
 jumpLimit = 1
end
end
Runtime:addEventListener("touch", onTouch)]]



function scene:create( event )

	local sceneGroup = self.view

    physics.pause()  -- Temporarily pause the physics engine

    -- Set up display groups
    backGroup = display.newGroup()  -- Display group for the background image
    sceneGroup:insert( backGroup )  -- Insert into the scene's view group

    mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
    sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

    uiGroup = display.newGroup()    -- Display group for UI objects like the score
    sceneGroup:insert( uiGroup )    -- Insert into the scene's view group

    --Background
    local background = display.newImageRect(backGroup, "ui/telas/sky.png", 554, 320)
    background.x = w/2 
    background.y = cY + oX --ok

    --Shape: Usada para fazer base para o jogador
    local base = display.newRect(backGroup, w/2, h-15, 600, 25 )
    base:setFillColor( 0.5 )
    physics.addBody( base, "static", {bounce = 0})

    -- Ground
    local gnd1 = display.newImageRect(backGroup,"ui/telas/street.png", 554, 90)
    gnd1.x = 0
    gnd1.y = 275
    gnd1.speed = speedGround

    local gnd2 = display.newImageRect(backGroup,"ui/telas/street.png", 554, 90)
    gnd2.x = 544 
    gnd2.y = 275
    gnd2.speed = speedGround

    -- Cloud
    local cloud1 = display.newImageRect(backGroup,"ui/telas/cloud1.png", 554, 50 )
    cloud1.x = 0
    cloud1.y = h/5
    cloud1.speed = cloudCity

    local cloud2 = display.newImageRect(backGroup,"ui/telas/cloud2.png", 554, 50 )
    cloud2.x = 544
    cloud2.y = h/5
    cloud2.speed = cloudCity

    -- City
    local city1 = display.newImageRect(backGroup,"ui/telas/city1.png", 554, 130 )
    city1.x = cX
    city1.y = h-148
    city1.speed = speedCity

    local city2 = display.newImageRect(backGroup,"ui/telas/city2.png", 554, 130 )
    city2.x = cX+554
    city2.y = h-145
    city2.speed = speedCity

    --[[Credit and Debit
    local creditImg = display.newImage(uiGroup, "ui/background/credit.png", 130, 40)
    creditImg.x = cX-205
    creditImg.y = cY-130
    local debitImg = display.newImage(uiGroup, "ui/background/debit.png", 130, 40)
    debitImg.x = cX-70
    debitImg.y = cY-130
    ]]

    player = createPlayer("ui/sprite/sprite_boy2.png", "running")
    mainGroup:insert(player)
    physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0})
    player.isFixedRotation=true 
    player.gravityScale = 0.8

player.name = 'player'
player.x = cX-150
player.y = cY+100
physics.addBody(player, { radius=30, isSensor=true })
player:setSequence("running")
player:play()
playerT = player





    -- Display lives and score
    creditText = display.newText( uiGroup, "Credit " .. credit, 55, 29, "RifficFree-Bold.ttf", 20 )
    creditText:setFillColor( 0, 0, 0 )
    debitText = display.newText( uiGroup, "Debit " .. debit, 190, 29, "RifficFree-Bold.ttf", 20 )
    debitText:setFillColor( 0, 0, 0 )

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
