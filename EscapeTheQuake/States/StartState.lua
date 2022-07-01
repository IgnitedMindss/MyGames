StartState = Class{__includes = BaseState}

function StartState:init()
    self.instructSheet = love.graphics.newImage('Assets/instructSheet.png')
    self.instructQuad = GenerateQuads(self.instructSheet, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self.currLayer = 1
    self.showTitle = true
end

function StartState:update(dt)
    if camScroll <=10000 then
        camScroll = camScroll + dt * 50
    end

    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') or love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        if self.currLayer > 1 then
            self.currLayer = self.currLayer - 1
        end
    end

    if love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') or love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s')then
        if self.currLayer < 4 then
            self.currLayer = self.currLayer + 1
        end
    end

    if love.keyboard.wasPressed('space') or (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
        if self.showTitle then
        else
            gStateMachine:change('play')
        end
    end

    if self.showTitle and (love.keyboard.wasPressed('space') or (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return'))) then
        self.showTitle = false
    end
end

function StartState:render()
    if self.showTitle then
        love.graphics.setFont(gFonts['large'])
        love.graphics.print("Escape the Quake", math.floor(camScroll) + 40, VIRTUAL_HEIGHT / 2 - 40)
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1,0,0,1)
        love.graphics.print(counters[4] == 0 and "Press space or enter to skip" or "", math.floor(camScroll) + 120, VIRTUAL_HEIGHT / 2 + 50)
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.draw(self.instructSheet, self.instructQuad[self.currLayer], math.floor(camScroll), 0)
    end
end