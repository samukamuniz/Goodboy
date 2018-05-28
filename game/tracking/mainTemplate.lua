local composer 		= require("composer")
local baseLevel 	= require("game.tracking.tracking_levels")
local baseElements 	= require("game.tracking.tracking_elements")
local progress 		= require("game.tracking.tracking_progress")
local sounds 		= require("sounds" )

local lvl = {} 
local uiGroup = display.newGroup()
local collectGroup = display.newGroup()

local background
local cityAux1
local cityAux2

local credit = 0	--Credit
local debit = 0		--Debit
local life = 0		--Vidas
local score = 0
local balance = 0

local creditText
local debitText
local lifeText
local balanceText

local speed = 10;
local jumpLimit = 0

local gamePaused = false
local playerT

local invoices = {}		--Cria vetor de despesas
local invCount = 0		--Qtd de elementos de despesas
local invoicesD = 0		--Despesas desaparecidas

local incomes = {}
local incCount = 0
local incomesD = 0

local currentLevel

local cX = display.contentCenterX -- Coordenada X
local cY = display.contentCenterY -- Coordenada Y
local acW = display.actualContentWidth
local acH = display.actualContentHeight
local fonte = "RifficFree-Bold.ttf"
local fonteT = 20

local function gotoGame()
	composer.gotoScene( "game.menu.menu" )
	display.remove(pauseGroup)
end

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

	pauserect = display.newRect(0, 0, display.contentWidth+450, 640)
	pauserect.x = display.contentWidth/2 + 180
	pauserect:setFillColor(0)
	pauserect.alpha = 0.75
	pauserect:addEventListener("tap", function() return true end)
	pauseGroup:insert(pauserect)

	resumebox = display.newImageRect("images/events/gamePaused.png", 304, 176 )
		resumebox.x = display.contentWidth/2
		resumebox.y = display.contentHeight/2
		pauseGroup:insert(resumebox)

	resumebtn = display.newImageRect("images/buttons/playBtn.png", 55, 55)
		resumebtn.x = 200
		resumebtn.y = 280
		resumebtn:addEventListener("tap", resumeGame)
		pauseGroup:insert(resumebtn)

	backmenuBtn = display.newImageRect("images/buttons/menuBtn.png", 55, 55)
		backmenuBtn.x = 280
		backmenuBtn.y = 280
		backmenuBtn:addEventListener("tap", gotoGame)
		pauseGroup:insert(backmenuBtn)

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
		local pausebtn = display.newImageRect("images/buttons/pauseBtn.png", 60, 60)
		pausebtn.x = display.contentWidth
		pausebtn.y = 280
		pausebtn:addEventListener("tap", pauseGame)
		playerT = player
		print(playerT)
		headerGroup:insert(pausebtn)
end

function lvl:buildHeader() --Faixa la em cima
	headerGroup = display.newGroup()
	
	local base = display.newRect(headerGroup, cX, cY-140, 570, 60 )
    base:setFillColor(0)

    local head = display.newImageRect(headerGroup, "images/elements/head.png", 570, 60)
    head.x = cX
    head.y = cY-130

	debitText = display.newText(headerGroup, debit, 0, 0, fonte, fonteT)
	debitText.x = cX-200
	debitText.y = 30
	debitText:setFillColor( 0, 0, 0 )

	creditText = display.newText(headerGroup, credit, 0, 0, fonte, fonteT)
	creditText.x = cX-60
	creditText.y = 30
	creditText:setFillColor( 0, 0, 0 )

	lifeText = display.newText(headerGroup, life, 0, 0, fonte, fonteT)
	lifeText.x = cX+80
	lifeText.y = 30
	lifeText:setFillColor( 0, 0, 0 )

	balanceText = display.newText(headerGroup, balance, 0, 0, fonte, fonteT)
	balanceText.x = cX+220
	balanceText.y = 30
	balanceText:setFillColor( 0, 0, 0 )

	return headerGroup
end

function lvl:addDebit(score)
	debit = debit + score
	debitText.text = debit
	lvl:decreaseBalance(score)
end

function lvl:addCredit(score)
	credit = credit + score
	creditText.text = credit
	lvl:increaseBalance(score)
end

function lvl:addlife(score)
	life = life + score
	life.text = life
end

function lvl:reducelife(score)
	life = life - score
	lifeText.text = life
end

function lvl:increaseBalance(credit)
	balance = balance + credit
	balanceText.text = balance
end

function lvl:decreaseBalance(debit)
	balance = balance - debit
	balanceText.text = balance
end

function lvl:zeraBalance(value)
	balance = value
	balanceText.text = balance
end

function lvl:isAlive()
	if( balance>=0) then
		return true
	elseif (life > 0) then
		lvl:reducelife(1)
		lvl:zeraBalance(0)
		return true
	else
		return false
	end
end

function lvl:isNextLevel()
	
	if (currentLevel==1) then
		if( balance<500) then
			return true
		else
			return false
		end
	elseif (currentLevel==2) then
		if( balance<1000) then
			return true
		else
			return false
		end
	elseif (currentLevel==3) then
		if( balance<2500) then
			return true
		else
			return false
		end
	end
end

function lvl:setValues(lifeValue, creditValue, debitValue)
	life = lifeValue
	credit = creditValue
	debit = debitValue
	balance = credit
end

function lvl:createBackground(currentLevel)
	local backGroup = display.newGroup() 

	background = display.newImageRect(backGroup, baseLevel.levels[currentLevel].sky, acW, acH )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	backGroup:insert(background)

	local aux1 = math.random(1, baseLevel.levels[currentLevel].qtdCity) -- Deifini o intervalo de opções	
	cityAux1 = display.newImage(baseLevel.levels[currentLevel].city[aux1].path)
	cityAux1.y = baseLevel.levels[currentLevel].city[aux1].y
	cityAux1.x = 240
	backGroup:insert(cityAux1)

	local aux2 = math.random(1, baseLevel.levels[currentLevel].qtdCity)
	
	cityAux2 = display.newImage(baseLevel.levels[currentLevel].city[aux2].path)
	cityAux2.x = 760
	cityAux2.y = baseLevel.levels[currentLevel].city[aux2].y
	backGroup:insert(cityAux2)

	return backGroup

end

function lvl:updateBackground(currentLevel)
	local backGroup = display.newGroup()

	cityAux1.x = cityAux1.x - (speed/5)

	if(cityAux1.x < -239) then
		local aux1 = math.random(1, baseLevel.levels[currentLevel].qtdCity)
		cityAux1:removeSelf()
		cityAux1 = display.newImage(baseLevel.levels[currentLevel].city[aux1].path)
		cityAux1.y = baseLevel.levels[currentLevel].city[aux1].y
		cityAux1.x = 760
		
		backGroup:insert(cityAux1)
	end

	cityAux2.x = cityAux2.x - (speed/5)
	if(cityAux2.x < -239) then
		local aux2 = math.random(1, baseLevel.levels[currentLevel].qtdCity)
		cityAux2:removeSelf()
		cityAux2 = display.newImage(baseLevel.levels[currentLevel].city[aux2].path)
		cityAux2.y = baseLevel.levels[currentLevel].city[aux2].y
		cityAux2.x = 760
		
		backGroup:insert(cityAux2)
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

function lvl:createInvoices(currentLevel)

	local height = math.random(100, display.contentHeight-80)
	local numBills = math.random(1, baseElements.qtdBill)
	
	invoices[invCount] = display.newImageRect(baseElements.bills[numBills].path, 55, 55)
	invoices[invCount].x = display.contentWidth + 50
	invoices[invCount].y = height
	invoices[invCount].name = baseElements.bills[numBills].name
	invoices[invCount].value = baseElements.bills[numBills].value
	invoices[invCount].type = baseElements.bills[numBills].type
	invoices[invCount].id = invCount
	physics.addBody(invoices[invCount], "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
	invCount = invCount + 1
	return invoices[invCount - 1]
end

function lvl:moveInvoices()
	for a = 0, invCount, 1 do
		if invoices[a] ~= nil and invoices[a].x ~= nil then
			if invoices[a].x < -100 then
				invoicesD = invoicesD + 1
				timer.performWithDelay(1, function()
					invoices[a] = nil;
				end, 1)
			else
				invoices[a].x = invoices[a].x  - (5/2)  -- spped/2
			end
		end
	end
end

function lvl:collideInvoices()
	invoicesD = invoicesD + 1
end

function lvl:createIncomes(currentLevel)
	local height = math.random(100, display.contentHeight-80)	
	local numColl = math.random(1, baseElements.qtdMoney)
	print(numColl)
	
	incomes[incCount] = display.newImageRect(baseElements.moneys[numColl].path, 55, 55)
	incomes[incCount].x = display.contentWidth + 50
	incomes[incCount].y = height
	incomes[incCount].name = 	baseElements.moneys[numColl].name	
	incomes[incCount].value = 	baseElements.moneys[numColl].value
	incomes[incCount].type = 	baseElements.moneys[numColl].type
	incomes[incCount].id = incCount
	physics.addBody(incomes[incCount], "kinematic",  { isSensor = true, gravity = 0, density=0.0 })
	
	incCount = incCount + 1

	return incomes[incCount - 1]
end

function lvl:moveIncomes()
	for a = 0, incCount, 1 do
		if incomes[a] ~= nil and incomes[a].x ~= nil then
			if incomes[a].x < -100 then
				incomesD = incomesD + 1
				timer.performWithDelay(1, function()
					incomes[a] = nil;
				end, 1)
			else
				incomes[a].x = incomes[a].x  - (5/2)  -- spped/2
			end
		end
	end
end

function lvl:collideIncomes()
	incomesD = incomesD + 1
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
	incomes = {}
	incCount = 0
	invoices = {}
	invCount = 0
	score = 0
end

return lvl