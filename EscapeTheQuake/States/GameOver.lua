GameOver = Class{__includes = BaseState}

function GameOver:enter(params)
    self.totalSaved = params.totalSaved
    self.totalKilled = params.totalKilled
    self.PlayerX = params.PlayerX
    self.PlayerY = params.PlayerY
end

function GameOver:update(dt)
    self.PlayerX = self.PlayerX + dt * 50
    camScroll = self.PlayerX - (VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2)
    if love.keyboard.wasPressed('space') or (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
        gStateMachine:change('play')
    end
end

function GameOver:render()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0,1,0,1)
    love.graphics.print("Total Lives Saved: " .. tostring(self.totalSaved), math.floor(self.PlayerX), VIRTUAL_HEIGHT/2)
    love.graphics.setColor(1,0,0,1)
    love.graphics.print("Total Lives Lost: " .. tostring(self.totalKilled), math.floor(self.PlayerX), VIRTUAL_HEIGHT/2 - 50)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1,0,0,1)
    love.graphics.print(counters[4] == 0 and "Press space or enter to retry" or "", math.floor(self.PlayerX) - 100, VIRTUAL_HEIGHT/2 + 60)
    love.graphics.setColor(1,1,1,1)
end