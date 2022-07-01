GameOverState = Class{__includes = BaseState}

local volumeTime = 0
local isPlaying = true

local currSelect = 1
local isHighScore = false

function GameOverState:enter(params)
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime

    self.highScores = params.highScores
    self.score = params.sc

    if SHOW_HEALTH then
        self.player = params.playership
    end

    if not SHOW_HEALTH then
        self.oe1x = VIRTUAL_WIDTH/2 - 60
        self.oe1y = VIRTUAL_HEIGHT/2
        self.oe1r = 0
    
        self.oe2x = VIRTUAL_WIDTH/2 - 60 + 54
        self.oe2y = VIRTUAL_HEIGHT/2 + 37
        self.oe2r = 0
    
        self.oe3x = VIRTUAL_WIDTH/2 - 60 + 40
        self.oe3y = VIRTUAL_HEIGHT/2 + 40
        self.oe3r = 0
    
        self.oe4x = VIRTUAL_WIDTH/2 - 60 + 8
        self.oe4y = VIRTUAL_HEIGHT/2 + 53
        self.oe4r = 0
    
        self.oe5x = VIRTUAL_WIDTH/2 - 60 + 43
        self.oe5y = VIRTUAL_HEIGHT/2 + 2
        self.oe5r = 0
    
        self.oe6x = VIRTUAL_WIDTH/2 - 60 + 4
        self.oe6y = VIRTUAL_HEIGHT/2 + 4
        self.oe6r = 0
    end
end

function GameOverState:update(dt)

    if SHOW_HEALTH then
        self.player:update(dt)
    end

    self.starSpawnTime = self.starSpawnTime + (dt*10)

    if self.starSpawnTime > 1 then
        table.insert(self.stars, NonInteractObj(11, 15))
        self.starSpawnTime = 0
    end

    for k, star in pairs(self.stars) do
        star:update(dt)
    end

    for k, star in pairs(self.stars) do
        if star.remove then
            table.remove(self.stars, k)
        end
    end

    local highScore = false
    local scoreIndex = 11

    for i = 10, 1, -1 do
        local score = self.highScores[i].score or 0
        if self.score > score then
            scoreIndex = i
            highScore = true
        end
    end

    if highScore then
        isHighScore = true
    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') or love.keyboard.wasPressed('w') or love.keyboard.wasPressed('s') then
        if MENU_SOUND then
            gSounds['select']:play()
            gSounds['select']:setVolume(0.5)
        end
        if isHighScore then
            if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
                if currSelect == 1 then
                    currSelect = 3
                else
                    currSelect = currSelect - 1
                end
            else
                if currSelect == 3 then
                    currSelect = 1
                else
                    currSelect = currSelect + 1
                end
            end
        else
            if currSelect == 1 then
                currSelect = currSelect + 1
            else
                currSelect = currSelect - 1
            end
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if MENU_SOUND then
            gSounds['confirm']:play()
            gSounds['confirm']:setVolume(0.5)
        end
        if currSelect == 1 then
            if SHOW_HEALTH then
                gPlayerHealth = 100
                gStateMachine:change('play2', {
                    highScores = self.highScores,
                    stars = self.stars,
                    starsSpawnTime = starSpawnTime
                })
            else
                gStateMachine:change('play', {
                    highScores = self.highScores,
                    stars = self.stars,
                    starsSpawnTime = starSpawnTime
                })
            end
        elseif currSelect == 2 then
            gStateMachine:change('start', {
                highScores = self.highScores
            })
        elseif currSelect == 3 then
            if isHighScore then
                gStateMachine:change('enterscore', {
                    highScores = self.highScores,
                    score = self.score,
                    scoreIndex = scoreIndex,
                    stars = self.stars,
                    starsSpawnTime = starSpawnTime
                })
            end
        end
        isPlaying = true
    end

    volumeTime = volumeTime + dt

    if volumeTime > 7 then
        if EAR_CRITICAL_SOUND then
            gSounds['gameOver']:stop()
        end
        volumeTime = 0
        isPlaying = false
    end

    if isPlaying then
        if EAR_CRITICAL_SOUND then
            gSounds['gameOver']:play()        
        end
    end

    if EAR_CRITICAL_SOUND then
        gSounds['gameOver']:setVolume(0.2)
    end

    if not SHOW_HEALTH then
        self.oe1r = self.oe1r + math.pi/19 * dt
        self.oe1x = self.oe1x + math.random(10) * dt
        self.oe1y = self.oe1y + math.random(10) * dt
    
        self.oe2r = self.oe2r + math.pi/19 * dt
        self.oe2x = self.oe2x + math.random(10) * dt
        self.oe2y = self.oe2y + math.random(10) * dt
    
        self.oe3r = self.oe3r + math.pi/19 * dt
        self.oe3x = self.oe3x + math.random(30) * dt
        self.oe3y = self.oe3y + math.random(30) * dt
    
        self.oe4r = self.oe4r + math.pi/19 * dt
        self.oe4x = self.oe4x - math.random(30) * dt
        self.oe4y = self.oe4y + math.random(30) * dt
    
        self.oe5r = self.oe5r - math.pi/19 * dt
        self.oe5x = self.oe5x + math.random(30) * dt
        self.oe5y = self.oe5y - math.random(30) * dt
    
        self.oe6r = self.oe6r - math.pi/19 * dt
        self.oe6x = self.oe6x - math.random(30) * dt
        self.oe6y = self.oe6y - math.random(30) * dt
    end
end

function GameOverState:render()
    for k, star in pairs(self.stars) do
        star:render()
    end

    if SHOW_HEALTH then
        self.player:render()
    end

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your Score', 0,  VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH / 2 + 380, 'center')
    love.graphics.printf(self.score, 0,  VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH / 2 + 380, 'center')

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('GAMEOVER', 0,  VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH / 2 + 380, 'center')

    if currSelect == 1 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('REPLAY?', 0,  VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH / 2 + 380, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 2 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('MAINMENU', 0,  VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH / 2 + 380, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if isHighScore then
        if currSelect == 3 then
            love.graphics.setFont(gFonts['medium'])
            love.graphics.setColor(1, 0, 1, 1)
        else
            love.graphics.setFont(gFonts['small'])
        end
        love.graphics.printf('YOU SCORED A HIGHSCORE, WANNA SAVE?', 0,  VIRTUAL_HEIGHT / 2 + 130, VIRTUAL_WIDTH / 2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end
    if not SHOW_HEALTH then
        love.graphics.draw(gTextures['overEarth1'], self.oe1x, self.oe1y, self.oe1r)
        love.graphics.draw(gTextures['overEarth2'], self.oe2x, self.oe2y, self.oe2r)
        love.graphics.draw(gTextures['overEarth3'], self.oe3x, self.oe3y, self.oe3r)
        love.graphics.draw(gTextures['overEarth4'], self.oe4x, self.oe4y, self.oe4r)
        love.graphics.draw(gTextures['overEarth5'], self.oe5x, self.oe5y, self.oe5r)
        love.graphics.draw(gTextures['overEarth6'], self.oe6x, self.oe6y, self.oe6r)
    end
end