EnterBestTimeState = Class{__includes = BaseState}

function EnterBestTimeState:init()
    self.nametyped = false
    self.name = ''
end

function EnterBestTimeState:enter(params)
    self.bestTimers = params.bestTimers
    self.curr_level = params.curr_level
    self.min = params.min
    self.sec = params.sec
    self.gemcollected = params.gemcollected or false
end

function EnterBestTimeState:update(dt)
    Timer.update(dt)

    if counters[2] > 1 then
        counters[2] = 0
    end

        if self.bestTimers[self.curr_level].min < self.min then
            gStateMachine:change('start', {
                bestTimers = self.bestTimers
            })
        elseif self.bestTimers[self.curr_level].sec < self.sec then
            gStateMachine:change('start', {
                bestTimers = self.bestTimers
            })
        else

            local gem_text = ''
            if self.gemcollected then
                gem_text = ' (with gem)'
            else
                gem_text = ''
            end

            if self.nametyped then
                self.bestTimers[self.curr_level].name = self.name .. gem_text
                self.bestTimers[self.curr_level].min = self.min
                self.bestTimers[self.curr_level].sec = self.sec
        
                local times = ''
        
                for i = 1, 5 do
                    times = times .. tostring(self.bestTimers[i].name) .. "\n"
                    times = times .. tostring(self.bestTimers[i].min) .. "\n"
                    times = times .. tostring(self.bestTimers[i].sec) .. "\n"
                end
        
                love.filesystem.write('MouseswayHome.lst', times)
        
                gStateMachine:change('start', {
                    bestTimers = self.bestTimers
                })
            else
                self:enterName(dt)
            end    
        end

        if love.keyboard.wasPressed("escape") then
            gStateMachine:change("start", {
                bestTimers = self.bestTimers
            })
        end
end

function EnterBestTimeState:render()
    -- love.graphics.print(tostring(self.bestTimers), 10, 1)
    -- love.graphics.print(tostring(self.curr_level), 10, 10)
    -- love.graphics.print(tostring(self.bestTimers[self.curr_level].min), 10, 20)
    -- love.graphics.print(tostring(self.gemcollected), 10, 30)

    if not self.nametyped then
        love.graphics.setFont(gFonts['medium'])
        if counters[2] == 0 then
            love.graphics.printf("New Record!", 1, VIRTUAL_HEIGHT / 2 - 90 + 1, VIRTUAL_WIDTH, 'center')
        end
        love.graphics.printf("Enter Your Name: " .. "\n" .. tostring(self.name), 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    end
end

function EnterBestTimeState:enterName(dt)
    if #self.name < 13 then 
        if love.keyboard.wasPressed("q") then
            self.name = self.name .. "q"
        elseif love.keyboard.wasPressed("w") then
            self.name = self.name .. "w"
        elseif love.keyboard.wasPressed("e") then
            self.name = self.name .. "e"
        elseif love.keyboard.wasPressed("r") then
            self.name = self.name .. "r"
        elseif love.keyboard.wasPressed("t") then
            self.name = self.name .. "t"
        elseif love.keyboard.wasPressed("y") then
            self.name = self.name .. "y"
        elseif love.keyboard.wasPressed("u") then
            self.name = self.name .. "u"
        elseif love.keyboard.wasPressed("i") then
            self.name = self.name .. "i"
        elseif love.keyboard.wasPressed("o") then
            self.name = self.name .. "o"
        elseif love.keyboard.wasPressed("p") then
            self.name = self.name .. "p"
        elseif love.keyboard.wasPressed("a") then
            self.name = self.name .. "a"
        elseif love.keyboard.wasPressed("s") then
            self.name = self.name .. "s"
        elseif love.keyboard.wasPressed("d") then
            self.name = self.name .. "d"
        elseif love.keyboard.wasPressed("f") then
            self.name = self.name .. "f"
        elseif love.keyboard.wasPressed("g") then
            self.name = self.name .. "g"
        elseif love.keyboard.wasPressed("h") then
            self.name = self.name .. "h"
        elseif love.keyboard.wasPressed("j") then
            self.name = self.name .. "j"
        elseif love.keyboard.wasPressed("k") then
            self.name = self.name .. "k"
        elseif love.keyboard.wasPressed("l") then
            self.name = self.name .. "l"
        elseif love.keyboard.wasPressed("z") then
            self.name = self.name .. "z"
        elseif love.keyboard.wasPressed("x") then
            self.name = self.name .. "x"
        elseif love.keyboard.wasPressed("c") then
            self.name = self.name .. "c"
        elseif love.keyboard.wasPressed("v") then
            self.name = self.name .. "v"
        elseif love.keyboard.wasPressed("b") then
            self.name = self.name .. "b"
        elseif love.keyboard.wasPressed("n") then
            self.name = self.name .. "n"
        elseif love.keyboard.wasPressed("m") then
            self.name = self.name .. "m"
        elseif love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
            self.nametyped = true
        end
    end

        if love.keyboard.wasPressed("backspace") then
            if #self.name > 1 then
                self.name = string.sub(self.name,1,#self.name - 1)
            else
                self.name = ''
            end
        end
end