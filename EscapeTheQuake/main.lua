push = require 'push'
Class = require 'class'
Timer = require 'knife.timer'

require 'Player'
require 'BrokenBuild'
require 'NPC'

require 'StateMachine'
require 'States/BaseState'
require 'States/StartState'
require 'States/PlayState'
require 'States/GameOver'

require 'Util'
require 'Animation'

WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

VIRTUAL_WIDTH = 490
VIRTUAL_HEIGHT = 220

CHARACTER_WIDTH = 24
CHARACTER_HEIGHT = 34

CHARACTER_MOVE_SPEED = 90
JUMP_VELOCITY = -200

GRAVITY = 7

-- camera scroll speed
CAMERA_SCROLL_SPEED = 40

GROUND = 2
SKY = 1

TILE_WIDTH = 32
TILE_HEIGHT = 29

BUILD_WIDTH = 138
BUILD_HEIGHT = 205

function love.load()
    -- intervals[1] -> earthquake
    -- intervals[2] -> broken spawntime
    -- intervals[3] -> npc spawntime
    -- intervals[4] -> press to continue display time
    -- intervals[5] -> decide which scream to use
    intervals = {1, 1, 1, 1, 1}
    counters = {0, 0, 0, 0, 0}

    for i = 1, #intervals do
        Timer.every(intervals[i], function()
            counters[i] = counters[i] + 1
        end)
    end

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Escape the Quake")

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/quake.ttf', 15),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 15),
        ['large'] = love.graphics.newFont('fonts/quake.ttf', 45)
    }

    gSounds = {
        ['earthquake'] = love.audio.newSource('Assets/sounds/earthquake-sound.wav', 'static'),
        ['saved_npc'] = love.audio.newSource('Assets/sounds/saved-npc.wav', 'static'),
        ['man_scream'] = love.audio.newSource('Assets/sounds/man-scream.wav', 'static'),
        ['man_scream2'] = love.audio.newSource('Assets/sounds/man-scream2.wav', 'static'),
        ['hit_player'] = love.audio.newSource('Assets/sounds/hit_player.wav', 'static'),
        ['killed'] = love.audio.newSource('Assets/sounds/killed.wav', 'static'),
    }

    mapHeight = 20
    mapWidth = 100

    camScroll = 0

    tiles = {}
    builds = {}
    objects = {}

    bg = love.graphics.newImage("Assets/bg.png")

    tilesheet = love.graphics.newImage("Assets/tiles.png")
    buildSheet = love.graphics.newImage("Assets/BuildSheet.png")
    buildQuads = GenerateQuads(buildSheet, 139, 205)
 
    quads = GenerateQuads(tilesheet, TILE_WIDTH, TILE_HEIGHT)

    objectsSheet = love.graphics.newImage("Assets/Objects/objectsSheet.png")
    objectsQuads = GenerateQuads(objectsSheet, 24, 39)

    signSheet = love.graphics.newImage("Assets/signSheet.png")
    signQuads = GenerateQuads(signSheet, 11, 11)

    quakeY = 0
    isQuake = false

    for y = 1, mapHeight do
        table.insert(tiles, {})
        for x = 1, mapWidth + 800 do
            table.insert(tiles[y], {
                id = y < 8 and SKY or GROUND
            })
        end
    end

    for x = 1, mapWidth do
        builds[x] = {buildObject = math.random(6)}
    end

    for x = 1, mapWidth + 800 do
        objects[x] = {objectSelect = math.random(6), space = math.random(260, 300)}
    end

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = true,
        resizable = true
    })

   gStateMachine = StateMachine{
       ['play'] = function ()
           return PlayState()
       end,
       ['start'] = function ()
        return StartState()
        end,
        ['over'] = function ()
            return GameOver()
            end,

   }

    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    Timer.update(dt)

    if counters[4] >=2 then
        counters[4] = 0
    end

    if counters[5] >=2 then
        counters[5] = 0
    end

    -- earthquake time
    if counters[1] > 5 then
        gSounds['earthquake']:play()
        if isQuake and quakeY > 0 then
            quakeY = quakeY + dt*100
            if quakeY >= 5 then
                quakeY = 5
                isQuake = false
            end
        end
        
        if (not isQuake) and quakeY < 6 then
            quakeY = quakeY - dt*100 
            if quakeY <= 1 then
                quakeY = 1
                isQuake = true
            end  
        end
    else
        gSounds['earthquake']:stop()
    end

    if counters[1] >= 15 then
        counters[1] = 0
    end
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == "escape" then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:start()

    -- less than zero covers the area we dont want player to see
    if camScroll > 0 then
        love.graphics.translate(-math.floor(camScroll), quakeY)
    end

    if camScroll > 0 then
        love.graphics.draw(bg, math.floor(camScroll), 0)
    else
        love.graphics.draw(bg, 0, 0)
    end

    for x = 1, mapWidth do
        love.graphics.draw(buildSheet, buildQuads[builds[x].buildObject], (x - 1) * (BUILD_WIDTH - 4), 0)
    end

    for y = 1, mapHeight do
        for x = 1, mapWidth + 800 do
            local tile = tiles[y][x]
            love.graphics.draw(tilesheet, quads[tile.id], (x - 1) * TILE_WIDTH, (y - 1) * TILE_HEIGHT)
        end
    end

    -- objects width -> 24 and height -> 39
    for x = 1, mapWidth + 800 do
        love.graphics.draw(objectsSheet, objectsQuads[objects[x].objectSelect], (x - 1) * objects[x].space, ((8 - 1) * TILE_HEIGHT) - 39)
    end


    gStateMachine:render()
    push:finish()
end