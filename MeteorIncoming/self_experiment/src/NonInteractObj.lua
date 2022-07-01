NonInteractObj = Class{}

function NonInteractObj:init(wigth, height)
    self.stars = love.graphics.newArrayImage(gTextures['stars'])
    self.type = math.random(5)
    self.x = math.random(100,1100)
    self.y = -200
    self.width = wigth
    self.height = height
    self.remove = false
end

function NonInteractObj:update(dt)
    if self.type == 1 then
        self.y = self.y + 300 * dt
        self.x = self.x - 210 * dt
    else
        self.y = self.y + 100 * dt
        self.x = self.x - 70 * dt
    end

    if self.y < VIRTUAL_HEIGHT + 110 then
        self.y = self.y + 100 * dt
        if self.x > -self.width then
            self.x = self.x -70 * dt
        else
            self.remove = true 
        end
    else
        self.remove = true
    end  
end

function NonInteractObj:render()
    love.graphics.drawLayer(self.stars,self.type, self.x, self.y)
end