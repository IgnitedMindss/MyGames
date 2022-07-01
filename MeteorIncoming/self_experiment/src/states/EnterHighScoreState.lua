EnterHighScoreState = Class{__includes = BaseState}

local chars = {
    [1] = 65,
    [2] = 65,
    [3] = 65
}

local currChar = 1

function EnterHighScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime
end

function EnterHighScoreState:update(dt)
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

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3])

        -- making space for new highscore by shifting scores
        for i = 10, self.scoreIndex, -1 do
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end

        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score

        -- write score
        local scoreStr = ''

        for i = 1, 10 do
            scoreStr = scoreStr .. self.highScores[i].name .. '\n'
            scoreStr = scoreStr .. tostring(self.highScores[i].score) .. '\n'
        end

        love.filesystem.write('MeteorIncoming.lst', scoreStr)

        gStateMachine:change('highscore', {
            highScores = self.highScores,
            stars = self.stars,
            starsSpawnTime = self.starSpawnTime
        })
    end
    
    -- scroll slots
    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') and currChar > 1 then
        currChar = currChar - 1
        if MENU_SOUND then
            gSounds['select']:play()
        end
    elseif love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') and currChar < 3 then
        currChar = currChar + 1
        if MENU_SOUND then
            gSounds['select']:play()
        end
    end

    -- scroll through char
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        chars[currChar] = chars[currChar] + 1
        if chars[currChar] > 90 then
            chars[currChar] = 65
        end
        if MENU_SOUND then
            gSounds['select']:play()
        end
    elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        chars[currChar] = chars[currChar] - 1
        if chars[currChar] < 65 then
            chars[currChar] = 90
        end
        if MENU_SOUND then
            gSounds['select']:play()
        end
    end
end

function EnterHighScoreState:render()
    for k, star in pairs(self.stars) do
        star:render()
    end

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your Score: ' .. tostring(self.score), 0, 30, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['large'])

    if currChar == 1 then
        love.graphics.setColor(1, 0, 1, 1)
    end
    love.graphics.print(string.char(chars[1]), VIRTUAL_WIDTH / 2 - 108, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if currChar == 2 then
        love.graphics.setColor(1, 0, 1, 1)
    end
    love.graphics.print(string.char(chars[2]), VIRTUAL_WIDTH / 2 - 70, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if currChar == 3 then
        love.graphics.setColor(1, 0, 1, 1)
    end
    love.graphics.print(string.char(chars[3]), VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to confirm!', 0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end