-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- Seed the random number generator
--math.randomseed( os.time() )

-- Reserve channel 1 for background music
--audio.reserveChannels( 1 )
--audio.setVolume( 0.3, { channel=1 } )
-- Go to the menu screen
composer.gotoScene( "game" )