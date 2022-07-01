StartState = Class{__includes = BaseState}

function StartState:init()
    self.curr_level = 1
end

function StartState:enter(params)
    self.bestTimers = params.bestTimers
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        counters[3] = 0
        gStateMachine:change('select-level-control', {
            bestTimers = self.bestTimers,
            curr_level = self.curr_level
        })
    end

    Timer.update(dt)

    if counters[2] > 1 then
        counters[2] = 0
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end

    gSounds["music"]:setLooping(true)
    gSounds["music"]:setVolume(0.8)
    gSounds["music"]:play()
end

function StartState:render()
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf("Mouse's way Home", 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    if counters[2] == 0 then
        love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 17, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.draw(gTextures['house'], gFrames['house'][1], VIRTUAL_WIDTH / 2 + 90, 35)
end