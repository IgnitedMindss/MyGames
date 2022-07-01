Entity = Class{}

function Entity:init(def)
    self.x = def.x
    self.y = def.y

    self.dx = 0
    self.dy = 0

    self.width = def.width
    self.height = def.height

    self.texture = def.texture
    self.stateMachine = def.stateMachine

    self.direction = 'left'

    self.map = def.map

    self.level = def.level

    self.curr_level = def.curr_level
    self.bestTimers = def.bestTimers

    self.gemcollected = false
end

function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:collides(entity)
    return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or 
                self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Entity:render()
    if self.gemcollected then
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle('fill', 398, 210, 60, 10)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("gem collected!", 400, 210)
    end

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()], 
                    math.floor(self.x) + 10.5, math.floor(self.y) + 10.5, 0, self.direction == 'right' and 1 or -1, 1, 10.5, 10.5)
end