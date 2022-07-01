Eagle = Class{__includes = Entity}

function Eagle:init(def)
    Entity.init(self, def)
end

function Eagle:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
                        math.floor(self.x) + 18, math.floor(self.y) + 20.5, 0, self.direction == 'left' and 1 or -1, 1, 18, 20.5)
    -- love.graphics.setColor(1, 0, 1, 1)
    -- love.graphics.rectangle('line',  math.floor(self.x) + 8, math.floor(self.y) + 20.5, self.width, self.height)
    -- love.graphics.setColor(1, 1, 1, 1)
end