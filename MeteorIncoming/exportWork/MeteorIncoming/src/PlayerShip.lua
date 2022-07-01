PlayerShip = Class{}

function PlayerShip:init()
    self.explosion = love.graphics.newArrayImage(gTextures['explosion'])
    self.isJet = false
    self.isDestroyed = false
    self.expFrame = 0

    self.body_x = VIRTUAL_WIDTH / 2 - 32
    self.body_y = VIRTUAL_HEIGHT - 100
    self.body_r = 0
    self.body_dx = 0
    self.body_dy = 0
    self.body_width = gTextures['ship_body']:getWidth()
    self.body_height = gTextures['ship_body']:getHeight()

    self.lwing_x = self.body_x - 20
    self.lwing_y = self.body_y + 37
    self.lwing_r = 0
    self.lwing_dx = 0
    self.rwing_dy = 0
    self.lwing_width = gTextures['leftWing']:getWidth()
    self.lwing_height = gTextures['leftWing']:getHeight()

    self.rwing_x = self.body_x + 13
    self.rwing_y = self.body_y + 37
    self.rwing_r = 0
    self.rwing_dx = 0
    self.rwing_dy = 0
    self.rwing_width = gTextures['leftWing']:getWidth()
    self.rwing_height = gTextures['leftWing']:getHeight()

    self.top_x = self.body_x + 6
    self.top_y = self.body_y - 8
    self.top_r = 0
    self.top_dx = 0
    self.top_dy = 0
    self.top_width = gTextures['leftWing']:getWidth()
    self.top_height = gTextures['leftWing']:getHeight()

    self.bottom_x = self.top_x - 2
    self.bottom_y = self.top_y + 64
    self.bottom_r = 0
    self.bottom_dx = 0
    self.bottom_dy = 0
    self.bottom_width = gTextures['leftWing']:getWidth()
    self.bottom_height = gTextures['leftWing']:getHeight()
end

function PlayerShip:update(dt)

    PLAYERSHIP_X = self.body_x
    PLAYERSHIP_Y = self.body_y

    self.expFrame = math.max((self.expFrame + 1 * (dt*10)) % #(gTextures['explosion']), 1)

    if gPlayerHealth > 0 then
        self.body_x = math.random(self.body_x - math.random(-0.2, 0.2), self.body_x)
        self.lwing_x = self.body_x - 20
        self.rwing_x = self.body_x + 13
        self.top_x = self.body_x + 6
        self.bottom_x = self.top_x - 2
    
    
        if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
            if PLAYERSHIP_SOUND then
                gSounds['jet']:play()
            end
            self.isJet = true
            self.body_dx = -SHIP_SPEED
            self.rwing_x = self.body_x + 10
            self.top_x = self.body_x + 2
            self.bottom_x = self.top_x - 2 
        elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
            if PLAYERSHIP_SOUND then
                gSounds['jet']:play()
            end
            self.isJet = true
            self.body_dx = SHIP_SPEED
            self.lwing_x = self.body_x - 18
            self.top_x = self.body_x + 10
            self.bottom_x = self.top_x - 2
        else
            if PLAYERSHIP_SOUND then
                gSounds['jet']:stop()
            end
            self.isJet = false
            self.body_dx = 0
        end
    
        if self.body_x < 150 then
            self.body_x = math.max(150, self.body_x + self.body_dx * dt)
        else
            self.body_x = math.min(VIRTUAL_WIDTH - 100, self.body_x + self.body_dx * dt)
        end 
    end

    -- if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    --     gSounds['player-dest']:play()
    --     self.isDestroyed = true
    -- end

    if gPlayerHealth <= 0 and SHOW_HEALTH then
        self.body_r = self.body_r + math.pi/9 * dt
        self.body_x = self.body_x + math.random(10) * dt
        self.body_y = self.body_y + math.random(10) * dt

        self.lwing_r = self.lwing_r - math.pi/9 * dt
        self.lwing_x = self.lwing_x + math.random(10) * dt
        self.lwing_y = self.lwing_y + math.random(10) * dt

        self.rwing_r = self.rwing_r + math.pi/9 * dt
        self.rwing_x = self.rwing_x + math.random(10) * dt
        self.rwing_y = self.rwing_y + math.random(10) * dt

        self.top_r = self.top_r - math.pi/9 * dt
        self.top_x = self.top_x + math.random(10) * dt
        self.top_y = self.top_y + math.random(10) * dt

        self.bottom_r = self.bottom_r + math.pi/9 * dt
        self.bottom_x = self.bottom_x + math.random(10) * dt
        self.bottom_y = self.bottom_y + math.random(10) * dt
    end
end

function PlayerShip:render()
    if gPlayerHealth <=0 and SHOW_HEALTH then
        love.graphics.drawLayer(self.explosion, self.expFrame, self.body_x - 130, self.body_y - 100) 
     end
    love.graphics.draw(gTextures['leftWing'], self.lwing_x, self.lwing_y, self.lwing_r)
    love.graphics.draw(gTextures['rightWing'], self.rwing_x, self.rwing_y, self.rwing_r)
    love.graphics.draw(gTextures['ship_top'], self.top_x, self.top_y, self.top_r)
    love.graphics.draw(gTextures['ship_bottom'], self.bottom_x, self.bottom_y, self.bottom_r)
    if self.isJet then
        love.graphics.draw(gTextures['ship_fire'], self.bottom_x + 2, self.bottom_y + 9) 
    end
    love.graphics.draw(gTextures['ship_body'], self.body_x, self.body_y, self.body_r)

    if SHOW_HEALTH then
        love.graphics.setColor(0,1,0,1)
        for i = gPlayerHealth, 1, -1  do
            do 
                love.graphics.rectangle('fill', self.lwing_x - 20, self.lwing_y + 40, i, 2)
            end
        end
        love.graphics.setColor(1,1,1,1)
    end

end