GameObject = Class{}

function GameObject:init(def)
    self.x = def.x
    self.y = def.y
    self.texture = def.texture
    self.width = def.width
    self.height = def.height
    self.frame = def.frame
    self.solid = def.solid
    self.collidable = def.collidable
    self.deadly = def.deadly
    self.consumable = def.consumable
    self.switch = def.switch
    self.ishome = def.ishome
    if (type(self.frame) == "table") then
        local interval = 0.15
        if self.texture == "smoke" then
            interval = 0.09
        end
        self.animation = Animation{
            frames = self.frame,
            interval = interval,
            onetime = self.texture == "smoke" and true or false
        }
        self.currentAnimation = self.animation
    end
end

function GameObject:collides(target)
    return not (target.x > self.x + self.width or self.x > target.x + target.width - 1 or
                target.y > self.y + self.height or self.y > target.y + target.height - 1)
end

function GameObject:update(dt)
    if (type(self.frame) == "table") then
            self.currentAnimation:update(dt)
    end   
end

function GameObject:render()
    if (type(self.frame) == "table")  then
        if self.texture == "gems" then
                love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()], self.x, self.y)
        else
            love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()], self.x, self.y)
        end
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x, self.y)
    end
end