require 'src/Dependencies'

function love.load()

    -- intervals[1] -> fireSpawnTime
    -- intervals[2] -> meteorSpawnTime
    -- intervals[3] -> earthSpawnTime
    --intervals[4] -> powerupHealth
    --intervals[5] -> powerupShield
    -- intervals[6] -> powerupExtraLaser
    -- intervals[7] -> powerSpeed
    -- intervals[8] -> Guide1
    -- intervals[9] -> GuideAmm2
    -- intervals[10] -> GuideAmm3
    -- intervals[11] -> GuideAmm4
    -- intervals[12] -> GuideBot
    -- intervals[13] -> GuideHealth
    -- intervals[14] -> GuideShield
    -- intervals[15] -> GuideGun
    -- intervals[16] -> GuideSpeed
    intervals = {0.10, 1, 0.1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3}
    counters = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

    -- Settings variables
    ALL_SOUND = true
    LASER_MISSLE_SOUND = true
    MET_DESTROY_SOUND = true
    EAR_CRITICAL_SOUND = true
    COLLECT_SOUND = true
    MENU_SOUND = true
    PLAYERSHIP_SOUND = true

    -- Guide variable
    GUIDE = true

    for i = 1, #intervals do
        Timer.every(intervals[i], function()
            counters[i] = counters[i] + 1
        end)
    end

    -- projectile for all bots
    bots = {}

    Timer.every(0.05, function ()
        for k, bot in pairs(bots) do
           bot.counter = bot.counter + 1 
        end
    end)

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Space')

    gFonts = {
        ['large'] = love.graphics.newFont('fonts/font.ttf', 60),
        ['midlarge'] = love.graphics.newFont('fonts/font.ttf', 30),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 22),
        ['small'] = love.graphics.newFont('fonts/font.ttf', 18),
        ['verySmall'] = love.graphics.newFont('fonts/font.ttf', 13),
        ['tiny'] = love.graphics.newFont('fonts/font.ttf', 10)
    }

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/bg.png'),
        ['ship_body'] = love.graphics.newImage('graphics/body.png'),
        ['leftWing'] = love.graphics.newImage('graphics/leftWing.png'),
        ['rightWing'] = love.graphics.newImage('graphics/rightWing.png'),
        ['ship_top'] = love.graphics.newImage('graphics/top.png'),
        ['ship_bottom'] = love.graphics.newImage('graphics/bottom.png'),
        ['ship_fire'] = love.graphics.newImage('graphics/fire.png'),
        ['explosion'] = {'graphics/explosion/exp1.png', 'graphics/explosion/exp2.png', 'graphics/explosion/exp3.png',
                        'graphics/explosion/exp4.png', 'graphics/explosion/exp5.png', 'graphics/explosion/exp6.png',
                        'graphics/explosion/exp7.png', 'graphics/explosion/exp8.png', 'graphics/explosion/exp9.png'
                        },
        ['lasers'] = {'graphics/laser/fire1.png', 'graphics/laser/fire2.png', 'graphics/laser/fire3.png', 'graphics/laser/fire4.png'},
        ['meteors'] = {'graphics/meteor/meteor1.png', 'graphics/meteor/meteor1.png', 'graphics/meteor/meteor3.png', 'graphics/meteor/meteor4.png', 'graphics/meteor/meteor5.png'},
        ['particle'] = love.graphics.newImage('graphics/particle/particle.png'),
        ['stars'] = {'graphics/stars/star.png', 'graphics/stars/star1.png', 'graphics/stars/star2.png', 'graphics/stars/star3.png', 'graphics/stars/star4.png'},
        ['earthArray'] = {'graphics/earth/earth1.png', 'graphics/earth/earth2.png', 'graphics/earth/earth3.png', 'graphics/earth/earth4.png'},
        ['earth'] = love.graphics.newImage('graphics/earth/earth1.png'),
        ['overEarth1'] = love.graphics.newImage('graphics/earth/overEarth1.png'),
        ['overEarth2'] = love.graphics.newImage('graphics/earth/overEarth2.png'),
        ['overEarth3'] = love.graphics.newImage('graphics/earth/overEarth3.png'),
        ['overEarth4'] = love.graphics.newImage('graphics/earth/overEarth4.png'),
        ['overEarth5'] = love.graphics.newImage('graphics/earth/overEarth5.png'),
        ['overEarth6'] = love.graphics.newImage('graphics/earth/overEarth6.png'),
        ['bots'] = {'graphics/bot/bot1.png', 'graphics/bot/bot2.png'},
        ['powerups'] = {'graphics/powerups/p1.png', 'graphics/powerups/p2.png', 'graphics/powerups/p3.png', 'graphics/powerups/p4.png', 'graphics/powerups/p5.png', 'graphics/powerups/p6.png', 'graphics/powerups/p7.png', 'graphics/powerups/p8.png',},
        ['collectables'] = {'graphics/collectables/c1.png', 'graphics/collectables/c2.png', 'graphics/collectables/c3.png', 'graphics/collectables/c4.png', 'graphics/collectables/c5.png', 'graphics/collectables/c6.png', 'graphics/collectables/c7.png', 'graphics/collectables/c8.png', 'graphics/collectables/c9.png'},
        ['ammo'] = {'graphics/ammo/ma1.png', 'graphics/ammo/mb1.png', 'graphics/ammo/mb2.png', 'graphics/ammo/mc1.png', 'graphics/ammo/mc2.png', 'graphics/ammo/md1.png', 'graphics/ammo/md2.png'}
    }

    gFrames = {
       ['earth'] = GenerateQuads(gTextures['earth'], 100, 100)
    }

    gSounds = {
        ['jet'] = love.audio.newSource('sounds/isJett.wav', 'static'),
        ['player-dest'] = love.audio.newSource('sounds/player-dest.wav', 'static'),
        ['laser1'] = love.audio.newSource('sounds/laser1.wav', 'static'),
        ['laser2'] = love.audio.newSource('sounds/laser2.wav', 'static'),
        ['laser3'] = love.audio.newSource('sounds/laser3.wav', 'static'),
        ['laser4'] = love.audio.newSource('sounds/laser4.wav', 'static'),
        ['collectable'] = love.audio.newSource('sounds/collectable.wav', 'static'),
        ['meteor-explode'] = love.audio.newSource('sounds/meteorExplode.wav', 'static'),
        ['meteor-hit'] = love.audio.newSource('sounds/meteorHit.wav', 'static'),
        ['emergency'] = love.audio.newSource('sounds/emergency.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['gameOver'] = love.audio.newSource('sounds/gameOver.wav', 'static'),
        ['bot-deploy'] = love.audio.newSource('sounds/bot-deploy.wav', 'static'),
        ['bot-destroy'] = love.audio.newSource('sounds/bot-destroy.wav', 'static')
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['start'] = function() return StartState() end,
        ['over'] = function() return GameOverState() end,
        ['control'] = function() return ControlsState() end,
        ['settings'] = function() return SettingsState() end,
        ['highscore'] = function() return HighScoreState() end,
        ['enterscore'] = function() return EnterHighScoreState() end
    }

    gStateMachine:change('start', {
        highScores = loadHighScores()
    })

    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    -- if love.keyboard.wasPressed('escape') then
    --     love.event.quit()
    -- end
    Timer.update(dt)

    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
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

    gStateMachine:render()

    push:finish()
end

function loadHighScores()
    love.filesystem.setIdentity('MeteorIncoming')

    if not love.filesystem.getInfo('MeteorIncoming.lst') then
        local scores = ''

        for i = 10, 1, -1 do
            scores = scores .. '---\n'
            scores = scores .. tostring(i * 10) .. '\n'
        end

        love.filesystem.write('MeteorIncoming.lst', scores)
    end

    local name = true
    local currentName = true
    local counter = 1

    local scores = {}

    for i = 1, 10 do
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    for line in love.filesystem.lines('MeteorIncoming.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        name = not name
    end

    return scores
end

