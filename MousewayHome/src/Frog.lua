Frog = Class{__includes = Entity}

function Frog:init(def)
    Entity.init(self, def)
end

function Frog:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
                        math.floor(self.x) + 15.5, math.floor(self.y) + 11, 0, self.direction == 'left' and 1 or -1, 1, 15.5, 11)
end