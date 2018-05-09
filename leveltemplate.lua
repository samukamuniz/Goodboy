local composer = require("composer")
local base = require( "base")
--local sounds = require( "soundsfile" )

local lvl = {} 
local uiGroup = display.newGroup()
local collectGroup = display.newGroup()

local background
local backgroundnear1
local backgroundnear2

local healthText
local health = 0
local happinessText
local happiness = 0
local money = 0
local moneyText


local credit = 0	--Credit
local debit = 0		--Debit
local life = 0		--Vidas
local score = 0

local creditText
local debitText
local lifeText

local speed = 20;
local jumpLimit = 0

local gamePaused = false
local playerT

local obstacles = {}				--Cria vetor de despesas
local obstaclesCounter = 0				--Qtd de elementos de despesas
local obstaclesDisappear = 0		--Despesas desaparecidas

local qtdBonusIncomes = 10 		-- Tiro

local collectibles = {}
local collectiblesCounter = 0
local collectiblesDisappear = 0

local currentLevel

function resumeGame()
	playerT:play()
	physics.start()
	timer.resume(movementLoop)
	timer.resume(emergeLoop)
	display.remove(pauseGroup)
	gamePaused = false
end

function pauseGame()
	gamePaused = true
	playerT:pause()
	physics.pause()
	timer.pause(movementLoop)
	timer.pause(emergeLoop)
	pauseGroup = display.newGroup()

	pauserect = display.newRect(0, 0, display.contentWidth+100, 640)
	pauserect.x = display.contentWidth/2 + 180
	pauserect:setFillColor(0)
	pauserect.alpha = 0.75
	pauserect:addEventListener("tap", function() return true end)
	pauseGroup:insert(pauserect)

	resumebox = display.newImageRect("ui/button/pause.png", display.contentWidth/2+200, display.contentHeight/2+100 )
		resumebox.x = display.contentWidth/2
		resumebox.y = display.contentHeight/2
		pauseGroup:insert(resumebox)

	resumebtn = display.newImageRect("ui/button/play.png", 60, 60)
		resumebtn.x = 100
		resumebtn.y = 100
		resumebtn:addEventListener("tap", resumeGame)
		pauseGroup:insert(resumebtn)

end

function lvl:createPlayer(playerSheet, sequence)

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

        sheet_player = graphics.newImageSheet(playerSheet, sheetData) 
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
        sheet_player = graphics.newImageSheet(playerSheet, sheetData)
        player = display.newSprite(sheet_player, sequencesPlayer)           
    end
	player.name = 'JOGADOR'
	player.x = 130
	player.y = 250
	player:setSequence("running")
	player:play()	

	playerT = player
	return player
end

function lvl:buildPause(player)
		local pausebtn = display.newImageRect("ui/button/btnPause.png", 50, 50)
		pausebtn.x = display.contentWidth
		pausebtn.y = 25
		pausebtn:addEventListener("tap", pauseGame)
		playerT = player
		print('---JOGADOR')
		print(playerT)
		headerGroup:insert(pausebtn)
end

function lvl:buildHeader(debitBoolean, lifeBoolean, creditBoolean) --Faixa la em cima
	headerGroup = display.newGroup()

	if(debitBoolean == true) then
		debitText = display.newText("Debit: $ ".. debit, 0, 0, "RifficFree-Bold.ttf", 20)
		debitText.x = 45
		debitText.y = 25
		headerGroup:insert(debitText)
	end

	if(creditBoolean == true) then
		creditText = display.newText("Credit: $ ".. credit, 0, 0, "RifficFree-Bold.ttf", 20)
		creditText.x = 200
		creditText.y = 25
		headerGroup:insert(creditText)
	end

	if(lifeBoolean == true) then
		life = display.newText("Life: $ ".. life, 0, 0, "RifficFree-Bold.ttf", 20)
		life.x = 350
		life.y = 25
		headerGroup:insert(life)
	end

	return headerGroup
end

--[[function lvl:createScoreProjectiles()
	numShoots = display.newText("teste" .. qtdBonusIncomes, 0, 0, "RifficFree-Bold.ttf", 30)
	numShoots.x = display.contentCenterX + 180
	numShoots.y = display.contentHeight-20
	uiGroup:insert(numShoots)
	return numShoots
end]]

function lvl:addBonusIncomes(score)
	qtdBonusIncomes = qtdBonusIncomes + score
	numShoots.text = "x" .. qtdBonusIncomes	
end

function lvl:reduceProjectiles(score)
	qtdBonusIncomes = qtdBonusIncomes - score
	numShoots.text = "x" .. qtdBonusIncomes	
end

function lvl:getqtdBonusIncomess()
	return qtdBonusIncomes
end

function lvl:addDebit(score)
	debit = debit + score
	debitText.text = "Debit: $ ".. debit
end

function lvl:reduceDebit(score)
	debit = debit - score
	debitText.text = "Debit: $ ".. debit
end

function lvl:addCredit(score)
	credit = credit + score
	creditText.text = "Credit: $ ".. credit
end

function lvl:reduceCredit(score)
	credit = credit - score
	creditText.text = "Credit: $ ".. credit
end

function lvl:addlife(score)
	life = life + score
	life.text = "Life: $ ".. life
end

function lvl:reducelife(score)
	life = life - score
	life.text = "Life: $ ".. life
end

function lvl:isAlive()
	if( health>0 and happiness>0 and money>0) then
		return true
	else
		return false
	end
end

function lvl:setValues(healthValue, moneyValue, happinessValue, weddingValue)
	health = healthValue
	money = moneyValue
	happiness = happinessValue
	--wedding = weddingValue
end

function lvl:createBackground(currentLevel)
	local backGroup = display.newGroup()

	background = display.newImageRect(backGroup, base.levels[currentLevel].background, 600, 250 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	backGroup:insert(background) --OK
	--ACIMA OK

	local aux1 = math.random(1, base.levels[currentLevel].numBackgroundsNear) -- Deifini o intervalo de opções	
	backgroundnear1 = display.newImage(base.levels[currentLevel].backgroundNear[aux1].path)
	backgroundnear1.y = base.levels[currentLevel].backgroundNear[aux1].y
	backgroundnear1.x = 240
	
	backGroup:insert(backgroundnear1)

	local aux2 = math.random(1, base.levels[currentLevel].numBackgroundsNear)
	
	backgroundnear2 = display.newImage(base.levels[currentLevel].backgroundNear[aux2].path)
	backgroundnear2.x = 760
	backgroundnear2.y = base.levels[currentLevel].backgroundNear[aux2].y
	backGroup:insert(backgroundnear2)

	return backGroup

end



function lvl:updateBackground(currentLevel)
	local backGroup = display.newGroup()

	backgroundnear1.x = backgroundnear1.x - (speed/5)

	if(backgroundnear1.x < -239) then
		local aux1 = math.random(1, base.levels[currentLevel].numBackgroundsNear)
		backgroundnear1:removeSelf()
		backgroundnear1 = display.newImage(base.levels[currentLevel].backgroundNear[aux1].path)
		backgroundnear1.y = base.levels[currentLevel].backgroundNear[aux1].y
		backgroundnear1.x = 760
		
		backGroup:insert(backgroundnear1)
	end

	backgroundnear2.x = backgroundnear2.x - (speed/5)
	if(backgroundnear2.x < -239) then
		local aux2 = math.random(1, base.levels[currentLevel].numBackgroundsNear)
		backgroundnear2:removeSelf()
		backgroundnear2 = display.newImage(base.levels[currentLevel].backgroundNear[aux2].path)
		backgroundnear2.y = base.levels[currentLevel].backgroundNear[aux2].y
		backgroundnear2.x = 760
		
		backGroup:insert(backgroundnear2)
	end

	return backGroup
end

function lvl:createFloor(groundImg)
	floorGroup = display.newGroup()
	local groundMin = 300
	local groundMax = 340
	local groundLevel = groundMin
	 
	for a = 1, 9, 1 do
		--AQUI GERAMOS O NOSSO CHÃO
		local newBlock
		newBlock = display.newImage(groundImg)
		newBlock.name = "GROUND"
		-- REPOSICIONANDO O CHÃO
		newBlock.x = (a * 79) - 85
		newBlock.y = groundLevel
		physics.addBody(newBlock, "static",  { density = 0, friction = 0, bounce = 0 })
		floorGroup:insert(newBlock)
	end

	return floorGroup
end

function lvl:moveFloor(blocks)
	for a = 1, blocks.numChildren, 1 do
		
	   if(a > 1) then
	   		newX = (blocks[a - 1]).x + 79
	   else
			newX = (blocks[9]).x + 70
	   end
		
	   if((blocks[a]).x < -80) then
	   		(blocks[a]).x, (blocks[a]).y = newX, 300
	   else
	   		(blocks[a]):translate(-5, 0)
	   end
		
	end
end

function lvl:createObstacle(currentLevel)

	local yVal = math.random(100, display.contentHeight-80)
	local numObst = math.random(1, base.levels[currentLevel].numObstacles)
	
	obstacles[obstaclesCounter] = display.newImageRect(base.levels[currentLevel].obstacles[numObst].path, 55, 55)
	obstacles[obstaclesCounter].x = display.contentWidth + 50
	obstacles[obstaclesCounter].y = yVal
	obstacles[obstaclesCounter].name = "OBSTACLE"
	obstacles[obstaclesCounter].id = obstaclesCounter
	obstacles[obstaclesCounter].type = base.levels[currentLevel].obstacles[numObst].type		
	physics.addBody(obstacles[obstaclesCounter], "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
	obstaclesCounter = obstaclesCounter + 1
	return obstacles[obstaclesCounter - 1]
end

function lvl:moveObstacles()
	for a = 0, obstaclesCounter, 1 do
		if obstacles[a] ~= nil and obstacles[a].x ~= nil then
			if obstacles[a].x < -100 then
				obstaclesDisappear = obstaclesDisappear + 1
				timer.performWithDelay(1, function()
					obstacles[a] = nil;
				end, 1)
			else
				obstacles[a].x = obstacles[a].x  - (5/2) -- spped/2
			end
		end
	end
end

function lvl:collideCollectible()
	obstaclesDisappear = obstaclesDisappear + 1
end

function lvl:collideObstacle()
	obstaclesDisappear = obstaclesDisappear + 1
end

function lvl:createCollectible(currentLevel)
	local yVal = math.random(100, display.contentHeight-80)
	
	local numColl = math.random(1, base.levels[currentLevel].numCollectibles)
	
	collectibles[collectiblesCounter] = display.newImageRect(base.levels[currentLevel].collectibles[numColl].path, 55, 55)
	collectibles[collectiblesCounter].x = display.contentWidth + 50
	collectibles[collectiblesCounter].y = yVal
	collectibles[collectiblesCounter].name = "COLECIONAVEL"	
	collectibles[collectiblesCounter].type = base.levels[currentLevel].collectibles[numColl].type
	collectibles[collectiblesCounter].id = collectiblesCounter
	physics.addBody(collectibles[collectiblesCounter], "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
	
	collectiblesCounter = collectiblesCounter + 1

	return collectibles[collectiblesCounter - 1]
end

function lvl:moveCollectibles()
	for a = 0, collectiblesCounter, 1 do
		if collectibles[a] ~= nil and collectibles[a].x ~= nil then
			if collectibles[a].x < -100 then
				collectiblesDisappear = collectiblesDisappear + 1
				timer.performWithDelay(1, function()
					collectibles[a] = nil;
				end, 1)
			else
				collectibles[a].x = collectibles[a].x  - (5/2)  -- spped/2
			end
		end
	end
end

function lvl:getYears()
	return years
end

function lvl:getCurrentLevel()
	return currentLevel
end

function lvl:setCurrentLevel(numCurrent)
	currentLevel = numCurrent
end

function lvl:getJumpLimit()
	return jumpLimit
end

function lvl:setJumpLimit(num)
	jumpLimit = jumpLimit
end

function lvl:destroy()
	display.remove(collectGroup)
	obstacles = {}
	collectibles = {}
	collectiblesCounter = 0
	obstaclesCounter = 0
	score = 0
end

return lvl