local composer = require("composer")
local base = require( "base")
--local sounds = require( "soundsfile" )

local lvl = {} 
local uiGroup = display.newGroup()
local collectGroup = display.newGroup()

local background
local ground1
local ground2
local base
local cloud1
local cloud2
local city1
local city2

local speedCity = 1
local speedGround = 2
local cloudCity = 0.5
physics.start()  -- Temporarily pause the physics engine

-- Coordenadas e Anchor Points
local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local oX = display.screenOriginX -- Centro X
local oY = display.screenOriginY -- Origem Y
local h = display.contentHeight
local w = display.contentWidth
local acw = display.actualContentWidth
local ach = display.actualContentHeight

local gamePaused = false
local playerT

local obstacles = {}
local obstaclesCounter = 0
local obstaclesDisappear = 0

local numProjectile = 10

local collectibles = {}
local collectiblesCounter = 0
local collectiblesDisappear = 0

local currentLevel

function lvl:createBackground(currentLevel)		--Adciona ao vetor lvl (Linha 5)
	local backGroup = display.newGroup()

	--BACKGROUND
	background = display.newImageRect(backGroup, "ui/telas/sky.png", acw, ach ) --OK
	background.x = w/2
	background.y = cY + display.screenOriginY
	backGroup:insert(background)
	--ACIMA OK

	--GROUND
	gnd1 = display.newImageRect( "ui/telas/street.png", 560, 90)
    gnd1.x = 0
    gnd1.y = 275
    gnd1.speed = speedGround
    backGroup:insert(gnd1)

	gnd2 = display.newImageRect( "ui/telas/street.png", 560, 90)
    gnd2.x = 544
    gnd2.y = 275
    gnd2.speed = speedGround
    backGroup:insert(gnd2)    

    --SHAPE
    base = display.newRect( w/2, h-15, 600, 25 )
    base:setFillColor( 0.5 )
    physics.addBody( base, "static", {bounce = 0})
    backGroup:insert(base)

    --CLOUD
    cloud1 = display.newImageRect( "ui/telas/cloud1.png", 554, 50)
    cloud1.x = 0
    cloud1.y = h/5
    cloud1.speed = cloudCity
    backGroup:insert(cloud1)

    cloud2 = display.newImageRect( "ui/telas/cloud2.png", 554, 50)
    cloud2.x = 544
    cloud2.y = h/5
    cloud2.speed = cloudCity
    backGroup:insert(cloud2)

    --CITY
    city1 = display.newImageRect( "ui/telas/city1.png", 554, 130)
    city1.x = cX
    city1.y = h-148
    city1.speed = speedCity
    backGroup:insert(city1)

    city2 = display.newImageRect( "ui/telas/city2.png", 554, 130)
    city2.x = cX+554
    city2.y = h-145
    city2.speed = speedCity
    backGroup:insert(city2)

	return backGroup
end

function lvl:setValues(lifeValue, debitValue, creditValue)
	life = healthValue 			--health
	debit = moneyValue			--money
	credit = happinessValue		--happiness
	--wedding = weddingValue	--wedding
end

function lvl:createPlayer(playerSheet, sequence)
	
	local spritePlayer = {
	    width=69;               --Largura Sprite
	    height=90;              --Altura Sprite
	    numFrames=10;            --Número de Frames
	    sheetContentWidth=345,  --Largura da Folha de Sprites
	    sheetContentHeight=180   --Altura da Folha de Sprites
	    -- 1 to 6 corre
	    -- 7 to 10 pula
	}

	local sheet_player
	local player 

	if(sequence == "running") then
		local sequencesPlayer = {{
			name = "running",
			start = 1,
			count = 6,
			time = 800,
			loopCount = 0,
			loopDirection = "forward"
		}}

		sheet_player = graphics.newImageSheet( playerSheet, spritePlayer ) --Aqui e definido onde estar e como se movimenta o sprite
		player = display.newSprite(sheet_player, sequencesPlayer)		
	else
		local sequencesPlayer = {{
			name = "jumping",
			start = 7,
			count = 10,
			time = 1000,
			loopCount = 0,
			loopDirection = "forward"
		}}
		sheet_player = graphics.newImageSheet( playerSheet, spritePlayer)
		player = display.newSprite(sheet_player, sequencesPlayer)			
	end
	player.name = 'JOGADOR'
	player.x = cX-150
	player.y = cY+100
	player:setSequence("running")
	player:play()	

	playerT = player
	return player
end

function moveX( self, event )
	if (self.x < -272) then
		self.x = 806
	else
		self.x = self.x - self.speed
	end
end


return lvl