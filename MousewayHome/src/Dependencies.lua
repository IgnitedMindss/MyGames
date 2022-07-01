
--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

--
-- our own code
--

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/EnterBestTimeState'
require 'src/states/game/SelectLevelAndControlState'


-- entity states
require 'src/states/entity/PlayerFallingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerJumpState'
require 'src/states/entity/PlayerWalkingState'
require 'src/states/entity/PlayerDoubleJumpState'

require 'src/states/entity/eagle/EagleMovingState'
require 'src/states/entity/frog/FrogIdleState'
require 'src/states/entity/frog/FrogMovingState'

-- general
require 'src/Animation'
require 'src/Entity'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Eagle'
require 'src/Frog'
require 'src/Tile'
require 'src/TileMap'


gSounds = {
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['death'] = love.audio.newSource('sounds/death.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
    ['pickup'] = love.audio.newSource('sounds/pickup.wav', 'static'),
}

gTextures = {
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['spikes'] = love.graphics.newImage('graphics/spikes.png'),
    ['eagle'] = love.graphics.newImage('graphics/eagle.png'),
    ['house'] = love.graphics.newImage('graphics/house.png'),
    ['gems'] = love.graphics.newImage('graphics/gems.png'),
    ['frog-idle'] = love.graphics.newImage('graphics/frog-idle.png'),
    ['frog-run'] = love.graphics.newImage('graphics/frog-run.png'),
    ['crank'] = love.graphics.newImage('graphics/crank.png'),
    ['smoke'] = love.graphics.newImage('graphics/smoke.png'),
    ['controls'] = love.graphics.newImage('graphics/controls.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 21, 21),
    ['spikes'] = GenerateQuads(gTextures['spikes'], 11, 11),
    ['eagle'] = GenerateQuads(gTextures['eagle'], 36, 41),
    ['house'] = GenerateQuads(gTextures['house'], 36, 44),
    ['gems'] = GenerateQuads(gTextures['gems'], 15, 11),
    ['frog-idle'] = GenerateQuads(gTextures['frog-idle'], 31, 22),
    ['frog-run'] = GenerateQuads(gTextures['frog-run'], 34, 32),
    ['crank'] = GenerateQuads(gTextures['crank'], 18, 22),
    ['smoke'] = GenerateQuads(gTextures['smoke'], 41, 41),
    ['controls'] = GenerateQuads(gTextures['controls'], 490, 220)
}

tilesheet = love.graphics.newImage('graphics/tiles.png')
quads = GenerateQuads(tilesheet, TILE_SIZE, TILE_SIZE)

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['level'] = love.graphics.newFont('fonts/font.ttf', 28),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}