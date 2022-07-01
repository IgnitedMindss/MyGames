Bot = Class{}

function Bot:init(x, y, type, botprojectiles)
    self.bot = love.graphics.newArrayImage(gTextures['bots'])
    self.x = x
    self.y = y
    self.type = type
    self.botprojectiles = botprojectiles
    self.numHit = math.random(30, 40)
    self.remove = false
    self.interval = 1
    self.counter = 0
end

function Bot:update(dt)

    if self.counter > self.interval then
        self.runTimer = false

        if LASER_MISSLE_SOUND then
            gSounds['laser1']:stop()
            gSounds['laser1']:play()
            gSounds['laser1']:setVolume(0.5)
        end
        
        table.insert(self.botprojectiles, Projectile(self.x + (self.bot:getWidth()/2), self.y, self.type, -550))
        self.numHit = self.numHit - 0.1
        self.counter = 0
    end

    if self.numHit <= 0 then
        self.remove = true

        if COLLECT_SOUND then
            gSounds['bot-destroy']:stop()
            gSounds['bot-destroy']:play()
            gSounds['bot-destroy']:setVolume(0.5)
        end
    end
end

function Bot:render()
    love.graphics.drawLayer(self.bot, 1, self.x, self.y)
    love.graphics.setColor(0.41, 0.74, 0.18, 1)
    for i = self.numHit * self.type,1 * self.type,-1 do
        do 
            love.graphics.rectangle('fill', self.x, self.y, i, 2)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end