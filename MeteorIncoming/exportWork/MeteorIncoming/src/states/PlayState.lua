PlayState = Class{__includes = BaseState}

local isPaused = false
local isEscape = false
local currSelect = 1

local currMissle = 1

local score = 0
local scoreComp = 6000
local scoreComp1 = 3000

local fireSpawnTime = 0
local fireSpawnTimeComp = 0
local meteorSpawnTime = 0
local meteorSpawnTimeComp = 0

local earthFrameRate = 1
local earthSpawnTime = 0
local sirenSpawnTime = 0
local sirenSpawnColor = false
local earthArraySelector = 2
local temp_earthHealth = 75

local ammo2 = 0
local am2 = 2
local ammo3 = 0
local am3 = 4
local ammo4 = 0
local am4 = 6

local botType = 2
local isbot = false

local powerup1 = 1
local timer1 = 10
local isCollected1 = false
local powerup2 = 3
local timer2 = 10
local isCollected2 = false
local powerup3 = 5
local timer3 = 10
local isCollected3 = false
local powerup4 = 7
local speedTimer = 10
local isCollectedSp = false

local hPressed = false
gJPressed = false
local kPressed = false
local lPressed = false

gEarthHealth = 100

function PlayState:enter(params)
    self.highScores = params.highScores
    self.player = PlayerShip()
    self.ammo = love.graphics.newArrayImage(gTextures['ammo'])
    self.bot = love.graphics.newArrayImage(gTextures['bots'])
    self.powerups = love.graphics.newArrayImage(gTextures['powerups'])
    self.projectiles = {}
    self.botprojectiles = {}
    self.meteors = {}
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime
    self.collectables = {}
    self.intervals = intervals
    self.counters = counters
    self.guide = Guide()
end

function PlayState:update(dt)

    if GUIDE then
        self.guide:update(dt)
    end

    if isEscape then
        if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
            if MENU_SOUND then
                gSounds['select']:play()
                gSounds['select']:setVolume(0.5)
            end
            if currSelect == 1 then
                currSelect = 3
            else
                currSelect = currSelect - 1
            end
        elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
            if MENU_SOUND then
                gSounds['select']:play()
                gSounds['select']:setVolume(0.5)
            end
            if currSelect == 3 then
                currSelect = 1
            else
                currSelect = currSelect + 1
            end
        end

        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            if MENU_SOUND then
                gSounds['confirm']:stop()
                gSounds['confirm']:play()
                gSounds['confirm']:setVolume(0.5)
            end
    
            if currSelect == 1 then
                isEscape = false
                isPaused = false
            elseif currSelect == 2 then
                gStateMachine:change('start', {
                    highScores = self.highScores
                })
                temp_earthHealth = 75
                gEarthHealth = 100
                earthArraySelector = 2
                gTextures['earth'] = love.graphics.newImage('graphics/earth/earth1.png')
                score = 0
                ammo2 = 0
                ammo3 = 0
                ammo4 = 0
                sirenSpawnTime = 0
                sirenSpawnColor = false
                scoreComp = 3000
                scoreComp1 = 6000
                counters[2] = 0 -- meteorSpTime
                intervals[2] = 1
                starSpawnTime = 0

                counters[1] = 0 -- fireSpTime

                meteorSpawnTimeComp = 0

                isPaused = false
                isEscape = false
                currSelect = 1

                isbot = false
                isCollected1 = false
                isCollected2 = false
                isCollected3 = false
                isCollectedSp = false

                powerup1 = 1
                powerup2 = 3
                powerup3 = 5
                powerup4 = 7
            elseif currSelect == 3 then
                love.event.quit()
            end
        end
    end

    if love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('p') then
        if love.keyboard.wasPressed('escape') then
            if isEscape then
                isEscape = false
                isPaused = false
            else
                isEscape = true
                isPaused = true
            end
        else
            if not isEscape then
                if isPaused then
                    isPaused = false
                else
                    isPaused = true
                end
            end
        end
    end

    if not isPaused then

    fireSpawnTime = self.counters[1]
    fireSpawnTimeComp = self.intervals[1]
    meteorSpawnTime = self.counters[2]
    meteorSpawnTimeComp = self.intervals[2]
    earthSpawnTime = self.counters[3]

    if gEarthHealth <= 0 then
        gStateMachine:change('over', {
            sc = score,
            highScores = self.highScores,
            stars = self.stars,
            starsSpawnTime = self.starSpawnTime
        })
        temp_earthHealth = 75
        gEarthHealth = 100
        earthArraySelector = 2
        gTextures['earth'] = love.graphics.newImage('graphics/earth/earth1.png')
        score = 0
        ammo2 = 0
        ammo3 = 0
        ammo4 = 0
        sirenSpawnTime = 0
        sirenSpawnColor = false
        scoreComp = 3000
        scoreComp1 = 6000
        counters[2] = 0 -- meteorSpTime
        intervals[2] = 1
        starSpawnTime = 0

        counters[1] = 0 -- fireSpTime

        meteorSpawnTimeComp = 0

        isPaused = false
        isEscape = false
        currSelect = 1

        isbot = false
        isCollected1 = false
        isCollected2 = false
        isCollected3 = false
        isCollectedSp = false

        powerup1 = 1
        powerup2 = 3
        powerup3 = 5
        powerup4 = 7
    end

    if love.keyboard.wasPressed('1') then
        currMissle = 1
    elseif love.keyboard.wasPressed('2') then
        if ammo2 > 0 then
            currMissle = 2
        end
    elseif love.keyboard.wasPressed('3') then
        if ammo3 > 0 then
            currMissle = 3
        end
    elseif love.keyboard.wasPressed('4') then
        if ammo4 > 0 then
            currMissle = 4
        end
    end

    if GUIDE then
        if self.guide.meteorCome then
            self.meteors = {}
            collectgarbage("collect")
        end
    end

    if score>scoreComp1 then
        table.insert(self.collectables, Collectables())
        scoreComp1 = scoreComp1 + 3000
    end

    if score>scoreComp then
        if meteorSpawnTimeComp > 0.89 then
            scoreComp = scoreComp + 6000 
        end
        if meteorSpawnTimeComp > 0.9 then
            intervals[2] = math.max(0.9,intervals[2] - 0.01)
        elseif meteorSpawnTimeComp <= 0.9 then
            METEOR_SPEED_MAX = METEOR_SPEED_MAX + 1
        end
    end
    
    if gEarthHealth < 35 then
        sirenSpawnTime = sirenSpawnTime + dt
        
        if sirenSpawnTime > 1 then
            sirenSpawnColor = true
            if EAR_CRITICAL_SOUND then
                gSounds['emergency']:stop()
                gSounds['emergency']:play()
                gSounds['emergency']:setVolume(0.5)
            end
            sirenSpawnTime = 0
        end
    end

    if isbot then
        if love.keyboard.wasPressed('g') then
            if COLLECT_SOUND then
                gSounds['bot-deploy']:stop()
                gSounds['bot-deploy']:play()
                gSounds['bot-deploy']:setVolume(0.5)
            end
            table.insert(bots, Bot(self.player.body_x, self.player.body_y, currMissle, self.botprojectiles))
            isbot = false
        end
    end

    for k, bot in pairs(bots) do
        bot:update(dt)
    end

    for k, bot in pairs(bots) do
        if bot.remove then
            table.remove(bots, k)
        end        
    end

    if isbot then
        botType = 1
    else
        botType = 2
    end

    if gEarthHealth < temp_earthHealth then
        gTextures['earth'] = love.graphics.newImage(gTextures['earthArray'][earthArraySelector])
        temp_earthHealth = temp_earthHealth - 25
        earthArraySelector = math.min(earthArraySelector + 1, #(gTextures['earthArray']))
    end

    if earthSpawnTime > intervals[3] then
        earthFrameRate = math.max((earthFrameRate + 1) % #(gFrames['earth']), 1)
        counters[3] = 0
    end

    self.player:update(dt)

    self.starSpawnTime = self.starSpawnTime + (dt*10)

    if self.starSpawnTime > 1 then
        table.insert(self.stars, NonInteractObj(11, 15))
        self.starSpawnTime = 0
    end

    for k, star in pairs(self.stars) do
        star:update(dt)
    end

    for k, meteor in pairs(self.meteors) do
        meteor:update(dt)       
    end

    for k1, project in pairs(self.projectiles) do
        for k2, meteor in pairs(self.meteors) do
            if project:collides(meteor) then
                score = score + (5 + (meteor.type * project.laserType))
                project:hit()
                meteor:hit(currMissle)
            end
        end
    end

    for k1, project in pairs(self.botprojectiles) do
        for k2, meteor in pairs(self.meteors) do
            if project:collides(meteor) then
                score = score + (5 + (meteor.type * project.laserType))
                project:hit()
                meteor:hit(currMissle)
            end
        end
    end

    for k, collect in pairs(self.collectables) do
        if collect:collides(self.player) then

            if COLLECT_SOUND then
                gSounds['collectable']:play()
                gSounds['collectable']:setVolume(0.5)
            end

            if collect.type == 2 then
                if GUIDE then
                    self.guide.ammo2 = true
                end
                am2 = math.min(am2+1, 3)
                ammo2 = ammo2 + 300
            elseif collect.type == 3 then
                if GUIDE then
                    self.guide.ammo3 = true
                end
                am3 = math.min(am3+1, 5)
                ammo3 = ammo3 + 300
            elseif collect.type == 4 then
                if GUIDE then
                    self.guide.ammo4 = true
                end
                am4 = math.min(am4+1, 7)
                ammo4 = ammo4 + 300
            elseif collect.type == 5 then
                if GUIDE then
                    self.guide.isbot = true
                end
                isbot = true
            elseif collect.type == 6 then
                if GUIDE then
                    self.guide.c4 = true
                end
                powerup4 = math.min(powerup4+1, 8)
                isCollectedSp = true
            elseif collect.type == 7 then
                if GUIDE then
                    self.guide.c1 = true
                end
                powerup1 = math.min(powerup1+1, 2)
                isCollected1 = true
            elseif collect.type == 8 then
                if GUIDE then
                    self.guide.c2 = true
                end
                powerup2 = math.min(powerup2+1, 4)
                isCollected2 = true
            elseif collect.type == 9 then
                if GUIDE then
                    self.guide.c3 = true
                end
                powerup3 = math.min(powerup3+1, 6)
                isCollected3 = true
            end

            collect.remove = true
        end
    end

    if love.keyboard.wasPressed('h') then
        if isCollected1 then
            hPressed = true
        end
    end
    
    if hPressed then
        if isCollected1 then
                if counters[4] > intervals[4] then
                    gEarthHealth = math.min(gEarthHealth + 3, 100)
                    counters[4] = 0
                    timer1 = timer1 - 1
                end
            if timer1 <= 0 then
                isCollected1 = false
                powerup1 = powerup1 - 1
                timer1 = 10
                hPressed = false
            end
        end 
    end

    if love.keyboard.wasPressed('j') then
        if isCollected2 then
            gJPressed = true
        end
    end
    
    if gJPressed then
        if isCollected2 then
            if counters[5] > intervals[5] then
                counters[5] = 0
                timer2 = timer2 - 1
            end
            if timer2 <= 0 then
                isCollected2 = false
                powerup2 = powerup2 - 1
                timer2 = 10
                gJPressed = false
            end
        end
    end

    if love.keyboard.wasPressed('k') then
        if isCollected3 then
            kPressed = true
        end
    end
    
    if kPressed then
        if isCollected3 then
            if counters[6] > intervals[6] then
                counters[6] = 0
                timer3 = timer3 - 1
            end
            if timer3 <= 0 then
                isCollected3 = false
                powerup3 = powerup3 - 1
                timer3 = 10
                kPressed = false
            end
        end
    end

    if love.keyboard.wasPressed('l') then
        if isCollectedSp then
            lPressed = true
        end
    end
    
    if lPressed then
        if isCollectedSp then
            SHIP_SPEED = 750
            if counters[7] > intervals[7] then
                counters[7] = 0
                speedTimer = speedTimer - 1
            end
            if speedTimer <= 0 then
                powerup4 = powerup4 - 1
                isCollectedSp = false
                SHIP_SPEED = 450
                speedTimer = 10
                lPressed = false
            end
        end
    end


    if meteorSpawnTime > meteorSpawnTimeComp then
        table.insert(self.meteors, Meteor(METEOR_SPEED))
        counters[2] = 0
    end

    for k, meteor in pairs(self.meteors) do
        if meteor.remove then
            table.remove(self.meteors, k)
        end        
    end

    for k, project in pairs(self.projectiles) do
        project:update(dt)       
    end

    for k, project in pairs(self.botprojectiles) do
        project:update(dt)       
    end

    for k, collect in pairs(self.collectables) do
        collect:update(dt)
    end

    if love.keyboard.isDown('space') then
        if fireSpawnTime > fireSpawnTimeComp then
            if currMissle == 1 then
                if LASER_MISSLE_SOUND then
                    gSounds['laser1']:stop()
                    gSounds['laser1']:play()
                    gSounds['laser1']:setVolume(0.5)
                end
            elseif currMissle == 2 then
                if LASER_MISSLE_SOUND then
                    gSounds['laser2']:stop()
                    gSounds['laser2']:play()
                    gSounds['laser2']:setVolume(0.2)
                end
            elseif currMissle == 3 then
                if LASER_MISSLE_SOUND then
                    gSounds['laser3']:stop()
                    gSounds['laser3']:play()
                    gSounds['laser3']:setVolume(0.5)
                end
            elseif currMissle == 4 then
                if LASER_MISSLE_SOUND then
                    gSounds['laser4']:stop()
                    gSounds['laser4']:play()
                    gSounds['laser4']:setVolume(0.5)
                end
            end

            if currMissle > 1 then
                if currMissle == 2 then
                    ammo2 = math.max(0, ammo2 - 2)
                    if ammo2 == 0 then
                        am2 = am2 - 1
                        currMissle = 1
                    end
                elseif currMissle == 3 then
                    ammo3 = math.max(0, ammo3 - 2)
                    if ammo3 == 0 then
                        am3 = am3 - 1
                        currMissle = 1
                    end
                elseif currMissle == 4 then
                    ammo4 = math.max(0, ammo4 - 2)
                    if ammo4 == 0 then
                        am4 = am4 - 1
                        currMissle = 1
                    end
                end
            end

            table.insert(self.projectiles, Projectile(self.player.lwing_x + 10, self.player.lwing_y, currMissle, -550))
            if kPressed then
                table.insert(self.projectiles, Projectile(self.player.body_x + 5, self.player.lwing_y, currMissle, -550)) 
            end
            table.insert(self.projectiles, Projectile(self.player.rwing_x + 10, self.player.rwing_y, currMissle, -550))
            counters[1] = 0 
        end
    end

    for k, project in pairs(self.projectiles) do
        if project.remove then
            table.remove(self.projectiles, k)
        end        
    end

    for k, project in pairs(self.botprojectiles) do
        if project.remove then
            table.remove(self.botprojectiles, k)
        end        
    end

    for k, collet in pairs(self.collectables) do
        if collet.remove then
            table.remove(self.collectables, k)
        end
    end

    for k, star in pairs(self.stars) do
        if star.remove then
            table.remove(self.stars, k)
        end
    end

end
end

function PlayState:render()
    -- stars always on top
    for k, star in pairs(self.stars) do
        star:render()
    end

    if GUIDE then
        self.guide:render()
    end

    love.graphics.setFont(gFonts['small'])

    love.graphics.printf(score, 0, VIRTUAL_HEIGHT/4 - 100, VIRTUAL_WIDTH - 10, 'right')

    -- right collectables
    love.graphics.drawLayer(self.bot, botType, VIRTUAL_WIDTH - (self.bot:getWidth() + 7), gTextures['earth']:getHeight() + 50)

    love.graphics.drawLayer(self.powerups, powerup1, VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 100)
    if isCollected1 then
        love.graphics.setColor(0.41, 0.74, 0.18, 1)
        for i = timer1*4,1*4,-1 do
            do 
                love.graphics.rectangle('fill', VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 142, i, 2)
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.drawLayer(self.powerups, powerup2, VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 150)
    if isCollected2 then
        love.graphics.setColor(0.41, 0.74, 0.18, 1)
        for i = timer2*4,1*4,-1 do
            do 
                love.graphics.rectangle('fill', VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 192, i, 2)
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.drawLayer(self.powerups, powerup3, VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 200)
    if isCollected3 then
        love.graphics.setColor(0.41, 0.74, 0.18, 1)
        for i = timer3*4,1*4,-1 do
            do 
                love.graphics.rectangle('fill', VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 242, i, 2)
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    love.graphics.drawLayer(self.powerups, powerup4, VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 250)
    if isCollectedSp then
        love.graphics.setColor(0.41, 0.74, 0.18, 1)
        for i = speedTimer*4,1*4,-1 do
            do 
                love.graphics.rectangle('fill', VIRTUAL_WIDTH - (self.powerups:getWidth() + 7), gTextures['earth']:getHeight() + 292, i, 2)
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    -- left collectables
    love.graphics.drawLayer(self.ammo, 1, 5, gTextures['earth']:getHeight() + 30)
    love.graphics.print('unlimited', 40, gTextures['earth']:getHeight() + 50)

    love.graphics.drawLayer(self.ammo, am2, 5, gTextures['earth']:getHeight() + 110)
    love.graphics.print(ammo2, 40, gTextures['earth']:getHeight() + 130)

    love.graphics.drawLayer(self.ammo, am3, 5, gTextures['earth']:getHeight() + 190)
    love.graphics.print(ammo3, 40, gTextures['earth']:getHeight() + 210)

    love.graphics.drawLayer(self.ammo, am4, 5, gTextures['earth']:getHeight() + 270)
    love.graphics.print(ammo4, 40, gTextures['earth']:getHeight() + 290)

    for k, collect in pairs(self.collectables) do
        collect:render()
    end
    
    for k, bot in pairs(bots) do
        bot:render()
    end

    for k, meteor in pairs(self.meteors) do
        meteor:render()
    end

    for k, project in pairs(self.projectiles) do
        project:render()        
    end

    for k, project in pairs(self.botprojectiles) do
        project:render()        
    end

    for k, project in pairs(self.projectiles) do
        project:renderParticles()
    end

    for k, project in pairs(self.botprojectiles) do
        project:renderParticles()
    end

    self.player:render()

    love.graphics.setColor(1, 0, 0, 1)
    for i = gEarthHealth,5,-1 do
        do 
            love.graphics.rectangle('fill', i, gTextures['earth']:getHeight() + 10, 5, 5)
        end
    end

    if sirenSpawnColor then
        if sirenSpawnTime > 0.5 then
            sirenSpawnColor =false
        end 
    end

    if sirenSpawnColor == true then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)    
    end

    love.graphics.draw(gTextures['earth'], gFrames['earth'][earthFrameRate], 5, 5)

    if isPaused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.print('PAUSED', VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 - 50)
    end

    if isEscape then
        if currSelect == 1 then
            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1, 0, 1, 1)
        else
            love.graphics.setFont(gFonts['small'])
        end
        love.graphics.printf('RESUME', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    
        if currSelect == 2 then
            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1, 0, 1, 1)
        else
            love.graphics.setFont(gFonts['small'])
        end
        love.graphics.printf('MAIN MENU', 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    
        if currSelect == 3 then
            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1, 0, 1, 1)
        else
            love.graphics.setFont(gFonts['small'])
        end
        love.graphics.printf('EXIT', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

end

