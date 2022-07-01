Meteor = Class{}

function Meteor:init(speed)
    self.meteor = love.graphics.newArrayImage(gTextures['meteors'])
    self.x = math.random(0 + 200, VIRTUAL_WIDTH - 200)
    self.y = VIRTUAL_HEIGHT - 550
    self.type = math.random(#gTextures['meteors'])
    self.speed = speed
    self.width = 100
    self.height = 88
    self.r = math.random(-1, 0)
    self.remove = false
    if self.type == #gTextures['meteors'] then
        self.numHit = self.type + 15
    else
        self.numHit = self.type + 10    
    end
end

function Meteor:hit(currMissle)
    if self.numHit <= 0 then
        self.remove = true
        if MET_DESTROY_SOUND then
            gSounds['meteor-explode']:stop()
            gSounds['meteor-explode']:play()
            gSounds['meteor-explode']:setVolume(0.5) 
        end
    end
    if LASER_MISSLE_SOUND then
        gSounds['meteor-hit']:stop()
        gSounds['meteor-hit']:play()
        gSounds['meteor-hit']:setVolume(0.5)
    end
    self.numHit = self.numHit - currMissle
end

function Meteor:update(dt)

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
        if gJPressed == false then
            gEarthHealth = gEarthHealth - (5 + self.type) 
        end
        self.remove = true
    end    
end

function Meteor:render()
    love.graphics.drawLayer(self.meteor, self.type, self.x, self.y, self.r)
    love.graphics.setColor(1, 0, 0, 1)
    for i = self.numHit * self.type,1 * self.type,-1 do
        do 
            love.graphics.rectangle('fill', self.x, self.y, i, 2)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end
