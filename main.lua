-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Initialize variables
local creditExtra = 200
local debitar = 0
local creditar = 0
 
local boy
local gameLoopTimer
local livesText
local scoreText

-- Set up display groups
local backGroup = display.newGroup()  -- Display group for the background image
local mainGroup = display.newGroup()  -- Display group for the boy, asteroids, lasers, etc.
local uiGroup = display.newGroup()    -- Display group for UI objects like the score

-- Load the background
local background = display.newImageRect( backGroup, "ui/background/background.png", 570, 380 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local credit = display.newImageRect( backGroup, "ui/background/credit.png", 130, 35 )
credit.x = display.contentCenterX-200
credit.y = display.contentCenterY-120

local debit = display.newImageRect( backGroup, "ui/background/debit.png", 130, 55 )
debit.x = display.contentCenterX-50
debit.y = display.contentCenterY-120

local down = display.newImageRect( backGroup, "ui/background/down.png", 50, 50 )
down.x = display.contentCenterX-240
down.y = display.contentCenterY+130

local up = display.newImageRect( backGroup, "ui/background/up.png", 50, 50 )
up.x = display.contentCenterX-180
up.y = display.contentCenterY+130

local play = display.newImageRect( backGroup, "ui/background/play.png", 50, 50 )
play.x = display.contentCenterX+240
play.y = display.contentCenterY+130
-- end Load the background


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
animation.x = display.contentCenterX-180
animation.y = display.contentCenterY+50

animation.timeScale = 1.0
animation:setSequence( "run" )
animation:play( )

-- End the Sprite