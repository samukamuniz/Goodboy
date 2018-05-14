
local composer = require("composer") 	 	--Importa o Composer
local physics = require("physics") 		 	--Importa a Fisica

local sounds = require( "soundsfile" )	 	--Importa o Som

local level = require("leveltemplate")		--Importa o aqruivo leveltemplate.lua
local scene = composer.newScene()			-- Cria uma nova cena pelo Composer

composer.recycleOnSceneChange = true		-- Não sei o que faz

local backGroup = display.newGroup()		-- bg1 Cria um grupo para o Background
local mainGroup = display.newGroup()		-- Cria um grupo para o .....
local uiGroup = display.newGroup()			-- Cria um grupo para o .....

local jumpLimit = 0							-- Variável para Limite de pulo

function scene:create( event )
	
	local sceneGroup = self.view
	level:setCurrentLevel(1)				--Seta o nível atual
	--playGameMusic(babybgmusic)				--Importa do arquivo soundsfile.lua a musica 
	--audio.setVolume( 0.50, { channel=1 } ) 

	background = level:createBackground(level:getCurrentLevel()) --(OK) Adc o background relativo ao level
	backGroup:insert(background) -- OK

	player = level:createPlayer("ui/sprite/sprite_boy.png", "running")
	mainGroup:insert(player) -- OK

	level:setValues(1,100,0)		
		
	physics.start()		
	
	local floor = level:createFloor("ui/background/ground1.png")
	mainGroup:insert(floor)
		
	physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0})
	player.isFixedRotation=true	
	player.gravityScale = 0.8

	local function creationLoop(event)
		local aux = math.random(0, 10)

		if aux <= 6 then
			invoices = level:createInvoices(level:getCurrentLevel())
			mainGroup:insert(invoices)
		else
			incomes = level:createIncomes(level:getCurrentLevel())
			mainGroup:insert(incomes)
		end
	end

	local function update( event )
		level:moveIncomes()
		level:moveInvoices()
		level:moveFloor(floor)
		
		back = level:updateBackground(level:getCurrentLevel())
		backGroup:insert(back)
	end

	movementLoop = timer.performWithDelay(10, update, -1)
	emergeLoop = timer.performWithDelay(1000, creationLoop, -1 )

	local function playerCollision( self, event )
		
		if(event.other.name == "CHAO") then	
			jumpLimit = 0
		end

		-- AQUI EU GANHO DINHEIRO
		if( event.other.name == "money") then
			--playSFX(money)

			if event.other.value == "10" then
				level:addCredit(10)
			end
			if event.other.value == "20" then
				level:addCredit(20)
			end
			if event.other.value == "50" then
				level:addCredit(50)
			end
			if event.other.value == "100" then
				level:addCredit(100)
			end
			
			level:collideIncomes()
			timer.performWithDelay(1, function()
				event.other.alpha = 0
		        event.other = nil
		    end, 1)
			event.other:removeSelf();
			
		end

		-- AQUI EU PERCO DINHEIRO
		if( event.other.name == "bill") then
			--playSFX(money)
			
			if ( event.other.value == "drug") then
				level:addDebit(50)
				level:reduceCredit(50)
			end

			if ( event.other.value == "lotery") then
				level:addDebit(100)
				level:reduceCredit(100)
			end
	
			level:collideInvoices()
			if level:isAlive() then
				timer.performWithDelay(1, function()
					event.other.alpha = 0
					event.other = nil
				end, 1)
				event.other:removeSelf();
			else
				composer.gotoScene( "scene.gameover", { time=800, effect="crossFade" } )
			end				    	
		end
	end
	player.collision = playerCollision
	player:addEventListener("collision")
	--[[
	function goToNextLevel()
		timer.performWithDelay(500, function()
			--playSFX(lvlupsound)			
		end)
		local playery = player.y
		local playerx = player.x
		player = level:celebratePlayer(player, "ui/baby/celebrating.png")
		player.y = playery
		player.x = playerx
		timer.performWithDelay(1, function()
			physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0 })						
		end)
		jumpbtn:removeEventListener("touch", jumpbtn)		
		shootbtn:removeEventListener("touch", shootbtn)
		mainGroup:insert(player)
		timer.pause(emergeLoop)
		timer.pause(movementLoop)	

		toLeft = timer.performWithDelay(1, function()
			player.x = player.x - 1
			if(player.x < 0) then
				composer.gotoScene("scene.congratulations")
			end
		end, -1)
		timer.pause(toLeft)

		timer.performWithDelay(1500, function()
			playery = player.y
			playerx = player.x
			player:removeSelf()
			player = level:createPlayer("ui/baby/normal-sprite.png", "normalRun")
			player.x = playerx
			player.xScale = -1
			player.y = playery
			mainGroup:insert(player)
			timer.resume(toLeft)
			physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })			
			player:setSequence("normalRun")
			player:play()
		end)
	end]]

	jumpbtn = display.newImageRect("ui/button/up.png", 60, 60)
	jumpbtn.x = 0
	jumpbtn.y = display.contentHeight - 35

--Jump Function
	function jumpbtn:touch(event)
		if(event.phase == "began") then
			jumpLimit = jumpLimit + 1
			if jumpLimit < 3 then
			  physics.addBody(player, "dynamic", { density = 0, friction = 0, bounce = 0, gravity = 0 })
			  player:applyLinearImpulse(0, -0.50, player.x, player.y)
			end
		jumpLimit = 0
		end
	end
	--Runtime:addEventListener("touch", onTouch)

	jumpbtn:addEventListener("touch", jumpbtn)
	uiGroup:insert(jumpbtn)
		
	local header = level:buildHeader(true, true, true)
	uiGroup:insert(header)

	level:buildPause(player)

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
		timer.cancel(movementLoop)
		timer.cancel(emergeLoop)
		if(toLeft ~= nil) then
			timer.cancel(toLeft)			
		end
		level:destroy()		
		display.remove(mainGroup)
		display.remove(uiGroup)
		display.remove(backGroup)		
	elseif ( phase == "did" ) then
		physics.pause()
		composer.removeScene("level1")
		composer.hideOverlay()
		Runtime:removeEventListener( "collision", onLocalCollision)
		Runtime:removeEventListener("touch", onTouch)
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

return scene