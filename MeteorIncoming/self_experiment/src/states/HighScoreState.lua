HighScoreState = Class{__includes = BaseState}

function HighScoreState:enter(params)
    self.highScores = params.highScores
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime
end

function HighScoreState:update(dt)

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

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start', {
            highScores = self.highScores
        })
    end
end

function HighScoreState:render()

    for k, star in pairs(self.stars) do
        star:render()
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('HIGHSCORES', 0, VIRTUAL_HEIGHT - 440, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 60 + i * 33, 50, 'left')

        -- score name
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 60 + i * 33, 50, 'right')

        -- score itself
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 33, 100, 'right')
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('<- ESC', 5, 5)
end