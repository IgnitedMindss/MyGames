Collectables = Class{}

function Collectables:init()
    self.collect = love.graphics.newArrayImage(gTextures['collectables'])
    self.x = math.random(0 + 200, VIRTUAL_WIDTH - 200)
    self.y = VIRTUAL_HEIGHT - 550
    self.type = math.random(2,#gTextures['collectables'])
    self.speed = METEOR_SPEED
    self.width = 54
    self.height = 66
    self.r = 0
    self.remove = false
end

function Collectables:update(dt)
    if self.r > 0 then
        self.r = self.r + math.pi/9 * dt
    elseif self.r < 0 then
        self.r = self.r - math.pi/9 * dt
    else
        self.r = self.r    
    end
    
    if self.y < VIRTUAL_HEIGHT + 110 then
        self.y = self.y + self.speed * dt
    else
        self.remove = true
    end    
end

function Collectables:collides(target)
    if self.r == 0 then
        if self.x > target.lwing_x + target.lwing_width + target.body_width + target.rwing_width or target.lwing_x  > self.x + self.width then
            return false
        end
    
        if self.y > target.body_y + target.body_height or target.body_y  > self.y + self.height then
            return false
        end
    
        return true
    end
end

function Collectables:render()
    love.graphics.drawLayer(self.collect, self.type, self.x, self.y, self.r)
end