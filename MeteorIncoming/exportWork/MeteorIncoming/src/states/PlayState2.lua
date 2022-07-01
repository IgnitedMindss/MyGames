PlayState2 = Class{__includes = BaseState}


local isPaused = false
local isEscape = false
local currSelect = 1

local currMissle = 1

local score = 0
local scoreComp = 6000
local scoreComp1 = 1000

local fireSpawnTime = 0
local fireSpawnTimeComp = 0
local enemySpawnTime = 0
local enemySpawnTimeComp = 0
local smallEnemySpawnTime = 0
local smallEnemySpawnTimeComp = 0


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

gPlayerHealth = 100

function PlayState2:enter(params)
    self.highScores = params.highScores
    self.player = PlayerShip()
    self.ammo = love.graphics.newArrayImage(gTextures['ammo'])
    self.bot = love.graphics.newArrayImage(gTextures['bots'])
    self.powerups = love.graphics.newArrayImage(gTextures['powerups'])
    self.projectiles = {}
    self.botprojectiles = {}
    self.enemyprojectiles = {}
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime
    self.collectables = {}
    self.enemys = {}
    self.smallenemys = {}
    self.intervals = intervals
    self.counters = counters
    self.guide = Guide()
end

function PlayState2:update(dt)

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
                gPlayerHealth = 100

                gTextures['earth'] = love.graphics.newImage('graphics/earth/earth1.png')
                score = 0
                ammo2 = 0
                ammo3 = 0
                ammo4 = 0
                scoreComp = 3000
                scoreComp1 = 6000
                starSpawnTime = 0

                enemySpawnTimeComp = 0
                smallEnemySpawnTimeComp = 0
                counters[17] = 0
                intervals[17] = 1.5
                counters[2] = 0
                intervals[2] = 3
                counters[1] = 0

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
    enemySpawnTime = self.counters[2]
    enemySpawnTimeComp = self.intervals[2]
    smallEnemySpawnTime = self.counters[17]
    smallEnemySpawnTimeComp = self.intervals[17]


    if gPlayerHealth <= 0 then
        gStateMachine:change('over', {
            sc = score,
            highScores = self.highScores,
            stars = self.stars,
            starsSpawnTime = self.starSpawnTime,
            playership = self.player
        })
        gTextures['earth'] = love.graphics.newImage('graphics/earth/earth1.png')
        score = 0
        ammo2 = 0
        ammo3 = 0
        ammo4 = 0
 
        scoreComp = 6000
        scoreComp1 = 1000
        starSpawnTime = 0

        enemySpawnTimeComp = 0
        smallEnemySpawnTimeComp = 0
        counters[17] = 0
        intervals[17] = 1.5
        counters[2] = 0
        intervals[2] = 3
        counters[1] = 0

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


    if score>scoreComp1 then
        table.insert(self.collectables, Collectables())
        scoreComp1 = scoreComp1 + 1000
    end

    if score>scoreComp then
        if enemySpawnTimeComp > 1 then
            intervals[2] = math.max(1,intervals[2] - 0.1)
        elseif enemySpawnTimeComp <= 1 then
            intervals[17] = math.max(1, intervals[17] - 0.01)
        end
        scoreComp = scoreComp + 6000
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


    self.player:update(dt)

    self.starSpawnTime = self.starSpawnTime + (dt*10)

    if self.starSpawnTime > 1 then
        table.insert(self.stars, NonInteractObj(11, 15))
        self.starSpawnTime = 0
    end

    for k, star in pairs(self.stars) do
        star:update(dt)
    end

    for k, enemy in pairs(self.enemys) do
        enemy:update(dt)
    end

    for k, enemy in pairs(self.smallenemys) do
        enemy:update(dt)
    end

    for k, project in pairs(self.enemyprojectiles) do
        if project:collides(self.player) then
            project.remove = true
            if gJPressed == false then
                gPlayerHealth = gPlayerHealth - (4 + project.laserType)
            end
        end
    end

    for k1, project in pairs(self.projectiles) do
        for k2, enemy in pairs(self.enemys) do
            if enemy.numHit > 0 then
                if project:collitionForEnemy(enemy) then
                    if LASER_MISSLE_SOUND then
                        gSounds['meteor-hit']:stop()
                        gSounds['meteor-hit']:play()
                        gSounds['meteor-hit']:setVolume(0.5)
                    end
                    enemy.numHit = enemy.numHit - project.laserType
                    score = score + (5 + (enemy.type * project.laserType))
                end
            end
        end
    end

    for k1, project in pairs(self.projectiles) do
        for k2, enemy in pairs(self.smallenemys) do
            if enemy.numHit > 0 then
                if project:collitionForSmallEnemy(enemy) then
                    if LASER_MISSLE_SOUND then
                        gSounds['meteor-hit']:stop()
                        gSounds['meteor-hit']:play()
                        gSounds['meteor-hit']:setVolume(0.5)
                    end
                    enemy.numHit = enemy.numHit - project.laserType
                    score = score + (5 + (enemy.type * project.laserType))
                end
            end
        end
    end

    for k1, project in pairs(self.botprojectiles) do
        for k2, enemy in pairs(self.enemys) do
            if project:collitionForEnemy(enemy) then
                if enemy.numHit > 0 then
                    if LASER_MISSLE_SOUND then
                        gSounds['meteor-hit']:stop()
                        gSounds['meteor-hit']:play()
                        gSounds['meteor-hit']:setVolume(0.5)
                    end
                    enemy.numHit = enemy.numHit - project.laserType
                    score = score + (5 + (enemy.type * project.laserType))
                end
            end
        end
    end

    for k1, project in pairs(self.botprojectiles) do
        for k2, enemy in pairs(self.smallenemys) do
            if enemy.numHit > 0 then
                if project:collitionForSmallEnemy(enemy) then
                    if LASER_MISSLE_SOUND then
                        gSounds['meteor-hit']:stop()
                        gSounds['meteor-hit']:play()
                        gSounds['meteor-hit']:setVolume(0.5)
                    end
                    enemy.numHit = enemy.numHit - project.laserType
                    score = score + (5 + (enemy.type * project.laserType))
                end
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
                    gPlayerHealth = math.min(gPlayerHealth + 3, 100)
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

    if enemySpawnTime > enemySpawnTimeComp then
        table.insert(self.enemys, EnemyShip(self.enemyprojectiles))
        counters[2] = 0
    end

    for k, enemy in pairs(self.enemys) do
        if enemy.remove then
            table.remove(self.enemys, k)
        end
    end

    if smallEnemySpawnTime > smallEnemySpawnTimeComp then
        table.insert(self.smallenemys, EnemySmallShip(self.enemyprojectiles))
        counters[17] = 0
    end

    for k, enemy in pairs(self.smallenemys) do
        if enemy.remove then
            table.remove(self.smallenemys, k)
        end
    end

    for k, project in pairs(self.projectiles) do
        project:update(dt)       
    end

    for k, project in pairs(self.botprojectiles) do
        project:update(dt)       
    end

    for k, project in pairs(self.enemyprojectiles) do
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

    for k, project in pairs(self.enemyprojectiles) do
        if project.remove then
            table.remove(self.enemyprojectiles, k)
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

function PlayState2:render()
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

    for k, enemy in pairs(self.enemys) do
        enemy:render()
    end

    for k, enemy in pairs(self.smallenemys) do
        enemy:render()
    end

    for k, project in pairs(self.projectiles) do
        project:render()        
    end

    for k, project in pairs(self.botprojectiles) do
        project:render()        
    end

    for k, project in pairs(self.enemyprojectiles) do
        project:render()
    end

    for k, project in pairs(self.projectiles) do
        project:renderParticles()
    end

    for k, project in pairs(self.botprojectiles) do
        project:renderParticles()
    end

    self.player:render()

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

