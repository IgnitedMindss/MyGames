SelectLevelAndControlState = Class{__includes = BaseState}

function SelectLevelAndControlState:enter(params)
    self.curr_level = params.curr_level
    self.bestTimers = params.bestTimers
end

function SelectLevelAndControlState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        counters[3] = 0
        gStateMachine:change('play', {
            bestTimers = self.bestTimers,
            curr_level = self.curr_level
        })
    end

    if love.keyboard.wasPressed("left") then
        if self.curr_level > 1 then
            self.curr_level = self.curr_level - 1
        end
    elseif love.keyboard.wasPressed("right") then
        if self.curr_level < 5 then
            self.curr_level = self.curr_level + 1
        end
    end

    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start", {
            bestTimers = self.bestTimers
        })
    end

    gSounds["music"]:stop()
end

function SelectLevelAndControlState:render()
    love.graphics.draw(gTextures['controls'], gFrames['controls'][1], 0, 0)
    love.graphics.setFont(gFonts['level'])
    love.graphics.print('< Level: ' .. self.curr_level .. ' >', VIRTUAL_WIDTH / 2 - 240, VIRTUAL_HEIGHT / 2)
end