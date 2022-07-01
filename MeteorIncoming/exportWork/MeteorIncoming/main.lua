require 'src/Dependencies'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- intervals[1] -> fireSpawnTime
    -- intervals[2] -> meteorSpawnTime/ enemySpawnTime
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
    -- intervals[17] -> smallEnemySpawnTime
    intervals = {0.10, 1, 0.1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1.5}
    counters = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

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

    math.randomseed(os.time())

    love.window.setTitle('Meteor Incoming')

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
        -- player ship
        ['ship_body'] = love.graphics.newImage('graphics/body.png'),
        ['leftWing'] = love.graphics.newImage('graphics/leftWing.png'),
        ['rightWing'] = love.graphics.newImage('graphics/rightWing.png'),
        ['ship_top'] = love.graphics.newImage('graphics/top.png'),
        ['ship_bottom'] = love.graphics.newImage('graphics/bottom.png'),
        ['ship_fire'] = love.graphics.newImage('graphics/fire.png'),

        -- select mode
        ['SaviorModeON'] = love.graphics.newImage('graphics/mode/SaviorModeON.png'),
        ['SaviorModeOFF'] = love.graphics.newImage('graphics/mode/SaviorModeOFF.png'),
        ['KillerModeON'] = love.graphics.newImage('graphics/mode/KillerModeON.png'),
        ['KillerModeOFF'] = love.graphics.newImage('graphics/mode/KillerModeOFF.png'),
        ['divider'] = love.graphics.newImage('graphics/mode/divider.png'),
        ['header'] = love.graphics.newImage('graphics/mode/header.png'),

        -- enemy ship ------------------------------------------------------------------------------------------------------
        -- different body shades
        ['enemyship_body'] = {'graphics/enemyship/body.png', 'graphics/enemyship/greenbody.png', 'graphics/enemyship/bluebody.png', 
                                'graphics/enemyship/blackbody.png'},

        -- different bottom body shades
        ['enemyship_bottomBody'] = {'graphics/enemyship/bottomBody.png', 'graphics/enemyship/greenbottomBody.png',
                                    'graphics/enemyship/bluebottomBody.png', 'graphics/enemyship/blackbottomBody.png'},

        -- different bottom left blades shades
        ['enemyship_bottomleftBlade'] = {'graphics/enemyship/bottomleftBlade.png', 'graphics/enemyship/greenbottomleftBlade.png', 
                                        'graphics/enemyship/bluebottomleftBlade.png', 'graphics/enemyship/blackbottomleftBlade.png'},

        -- different bottom right blades shades
        ['enemyship_bottomrightBlade'] = {'graphics/enemyship/bottomrightBlade.png', 'graphics/enemyship/greenbottomrightBlade.png', 
                                            'graphics/enemyship/bluebottomrightBlade.png', 'graphics/enemyship/blackbottomrightBlade.png'},

        -- different headlights shades
        ['enemyship_headLights'] = {'graphics/enemyship/headLights.png', 'graphics/enemyship/greenheadLights.png', 
                                    'graphics/enemyship/blueheadLights.png', 'graphics/enemyship/blackheadLights.png'},

        -- different leftbwing shades
        ['enemyship_leftbWing'] = {'graphics/enemyship/leftbWing.png', 'graphics/enemyship/greenleftbWing.png', 
                                    'graphics/enemyship/blueleftbWing.png', 'graphics/enemyship/blackleftbWing.png'},

        -- different leftwing shades
        ['enemyship_leftWing'] = {'graphics/enemyship/leftWing.png', 'graphics/enemyship/greenleftWing.png', 
                                    'graphics/enemyship/blueleftWing.png', 'graphics/enemyship/blackleftWing.png'},

        -- different leftWLB shades 
        ['enemyship_leftwingleftBlade'] = {'graphics/enemyship/leftwingleftBlade.png', 'graphics/enemyship/greenleftwingleftBlade.png', 
                                            'graphics/enemyship/blueleftwingleftBlade.png', 'graphics/enemyship/blackleftwingleftBlade.png'},

        -- different leftWRB shades
        ['enemyship_leftwingrightBlade'] = {'graphics/enemyship/leftwingrightBlade.png', 'graphics/enemyship/greenleftwingrightBlade.png', 
                                            'graphics/enemyship/blueleftwingrightBlade.png', 'graphics/enemyship/blackleftwingrightBlade.png'},

        -- different rightbwing shades
        ['enemyship_rightbWing'] = {'graphics/enemyship/rightbWing.png', 'graphics/enemyship/greenrightbWing.png', 
                                    'graphics/enemyship/bluerightbWing.png', 'graphics/enemyship/blackrightbWing.png'},

        -- different rightwing shades
        ['enemyship_rightWing'] = {'graphics/enemyship/rightWing.png', 'graphics/enemyship/greenrightWing.png', 
                                    'graphics/enemyship/bluerightWing.png', 'graphics/enemyship/blackrightWing.png'},

        -- different rightWLB shades
        ['enemyship_rightwingleftBlade'] = {'graphics/enemyship/rightwingleftBlade.png', 'graphics/enemyship/greenrightwingleftBlade.png', 
                                            'graphics/enemyship/bluerightwingleftBlade.png', 'graphics/enemyship/blackrightwingleftBlade.png'},

        -- different rightWRB shades
        ['enemyship_rightwingrightBlade'] = {'graphics/enemyship/rightwingrightBlade.png', 'graphics/enemyship/greenrightwingrightBlade.png', 
                                            'graphics/enemyship/bluerightwingrightBlade.png', 'graphics/enemyship/blackrightwingrightBlade.png'},

        -- different upperBody shades
        ['enemyship_upperBody'] = {'graphics/enemyship/upperBody.png', 'graphics/enemyship/greenupperBody.png', 
                                    'graphics/enemyship/blueupperBody.png', 'graphics/enemyship/blackupperBody.png'},

        -- different upperLB shades
        ['enemyship_upperleftBlade'] = {'graphics/enemyship/upperleftBlade.png', 'graphics/enemyship/greenupperleftBlade.png', 
                                        'graphics/enemyship/blueupperleftBlade.png', 'graphics/enemyship/blackupperleftBlade.png'},

        -- different upperRB shades
        ['enemyship_upperrightBlade'] = {'graphics/enemyship/upperrightBlade.png', 'graphics/enemyship/greenupperrightBlade.png', 
                                        'graphics/enemyship/blueupperrightBlade.png', 'graphics/enemyship/blackupperrightBlade.png'},

        ----------------------------------------------------------------------------------------------------------------------

        -- enemy small ship -------------------------------------------------------------------------------------------------
        -- different body shades
        ['enemysmallship_body'] = {'graphics/enemyship/smallShip/pinkBody.png', 'graphics/enemyship/smallShip/violetBody.png', 
                                    'graphics/enemyship/smallShip/blueBody.png', 'graphics/enemyship/smallShip/greenBody.png', 
                                    'graphics/enemyship/smallShip/indigoBody.png'},

        -- different left shades
        ['enemysmallship_left'] = {'graphics/enemyship/smallShip/pinkLeft.png', 'graphics/enemyship/smallShip/violetLeft.png', 
                                    'graphics/enemyship/smallShip/blueLeft.png', 'graphics/enemyship/smallShip/greenLeft.png',
                                    'graphics/enemyship/smallShip/indigoLeft.png'},

        -- diffrent right shades
        ['enemysmallship_right'] = {'graphics/enemyship/smallShip/pinkRight.png', 'graphics/enemyship/smallShip/violetRight.png',
                                    'graphics/enemyship/smallShip/blueRight.png', 'graphics/enemyship/smallShip/greenRight.png', 
                                    'graphics/enemyship/smallShip/indigoRight.png'},

        -----------------------------------------------------------------------------------------------------------------------
        

        ['explosion'] = {'graphics/explosion/exp1.png', 'graphics/explosion/exp2.png', 'graphics/explosion/exp3.png',
                        'graphics/explosion/exp4.png', 'graphics/explosion/exp5.png', 'graphics/explosion/exp6.png',
                        'graphics/explosion/exp7.png', 'graphics/explosion/exp8.png', 'graphics/explosion/exp9.png'
                        },
        ['enemyLasers'] = {'graphics/enemyLaser/laser1.png', 'graphics/enemyLaser/laser2.png', 'graphics/enemyLaser/laser3.png', 'graphics/enemyLaser/laser4.png'},
        ['smallenemyLasers'] = {'graphics/enemyLaser/smlaser1.png', 'graphics/enemyLaser/smlaser2.png', 'graphics/enemyLaser/smlaser3.png', 'graphics/enemyLaser/smlaser4.png', 'graphics/enemyLaser/smlaser5.png'},
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
        ['play2'] = function() return PlayState2() end,
        ['start'] = function() return StartState() end,
        ['select'] = function() return SelectState() end,
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

