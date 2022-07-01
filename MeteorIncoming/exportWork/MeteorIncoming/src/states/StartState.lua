StartState = Class{__includes = BaseState}

local currSelect = 1
local starSpawnTime = 0

function StartState:enter(params)
    self.highScores = params.highScores
    self.stars = {}
end

function StartState:update(dt)
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


    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        if MENU_SOUND then
            gSounds['select']:play()
            gSounds['select']:setVolume(0.5)
        end
        if currSelect == 1 then
            currSelect = 5
        else
            currSelect = currSelect - 1
        end
    elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        if MENU_SOUND then
            gSounds['select']:play()
            gSounds['select']:setVolume(0.5)
        end
        if currSelect == 5 then
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
            gStateMachine:change('select', {
                highScores = self.highScores,
                stars = self.stars,
                starsSpawnTime = starSpawnTime
            })
        elseif currSelect == 2 then
            gStateMachine:change('highscore', {
                highScores = self.highScores,
                stars = self.stars,
                starsSpawnTime = starSpawnTime
            })
        elseif currSelect == 3 then
            gStateMachine:change('control', {
                highScores = self.highScores,
                stars = self.stars,
                starsSpawnTime = starSpawnTime
            })
        elseif currSelect == 4 then
            gStateMachine:change('settings', {
                highScores = self.highScores,
                stars = self.stars,
                starsSpawnTime = starSpawnTime
            })
        elseif currSelect == 5 then
            love.event.quit()
        end
    end
end

function StartState:render()

    for k, star in pairs(self.stars) do
        star:render()
    end

    local BACKGROUND_WIDTH = gTextures['background']:getWidth()
    local BACKGROUND_HEIGHT = gTextures['background']:getHeight()
    love.graphics.draw(gTextures['background'], 0, 0, 0, VIRTUAL_WIDTH/(BACKGROUND_WIDTH - 1), VIRTUAL_HEIGHT/(BACKGROUND_HEIGHT - 1))

    --love.graphics.setFont(gFonts['small'])
    if currSelect == 1 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('START', 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 2 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('HIGHSCORES', 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 3 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('CONTROLS', 0, VIRTUAL_HEIGHT / 2 + 120, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 4 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('SETTINGS', 0, VIRTUAL_HEIGHT / 2 + 150, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 5 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('EXIT', 0, VIRTUAL_HEIGHT / 2 + 180, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

end