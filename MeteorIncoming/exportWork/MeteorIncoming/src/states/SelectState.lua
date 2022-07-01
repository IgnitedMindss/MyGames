SelectState = Class{__includes = BaseState}

local currSelect = 1
local starSpawnTime = 0

function SelectState:enter(params)
    self.highScores = params.highScores
    self.stars = params.stars
    self.starSpawnTime = params.starSpawnTime
end

function SelectState:update(dt)
    starSpawnTime = starSpawnTime + (dt*10)

    if starSpawnTime > 1 then
        table.insert(self.stars, NonInteractObj(11, 15))
        starSpawnTime = 0
    end

    for k, star in pairs(self.stars) do
        star:update(dt)
    end

    for k, star in pairs(self.stars) do
        if star.remove then
            table.remove(self.stars, k)
        end
    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') 
    or love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') 
    or love.keyboard.wasPressed('a') or love.keyboard.wasPressed('d') 
    or love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        if MENU_SOUND then
            gSounds['select']:play()
            gSounds['select']:setVolume(0.5)
        end
        if currSelect == 1 then
            currSelect = 2
        else
            currSelect = 1
        end    
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if MENU_SOUND then
            gSounds['confirm']:stop()
            gSounds['confirm']:play()
            gSounds['confirm']:setVolume(0.5)
        end
        if currSelect == 1 then
            SHOW_HEALTH = false
            intervals[2] = 1
            gStateMachine:change('play', {
            highScores = self.highScores,
            stars = self.stars,
            starsSpawnTime = starSpawnTime
            })
        else
            intervals[2] = 3
            SHOW_HEALTH = true
            gStateMachine:change('play2', {
            highScores = self.highScores,
            stars = self.stars,
            starsSpawnTime = starSpawnTime
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start', {
            highScores = self.highScores
        })
    end
end

function SelectState:render()
    for k, star in pairs(self.stars) do
        star:render()
    end

    love.graphics.draw(gTextures['header'], 320, 40)

    love.graphics.draw(gTextures['divider'], 400, 90)

    if currSelect == 1 then
        love.graphics.draw(gTextures['SaviorModeON'], 10, 90)
    else
        love.graphics.draw(gTextures['SaviorModeOFF'], 10, 100)
    end

    if currSelect == 2 then
        love.graphics.draw(gTextures['KillerModeON'], 500, 120)
    else
        love.graphics.draw(gTextures['KillerModeOFF'], 500, 140)
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('<- ESC', 5, 5)
end

