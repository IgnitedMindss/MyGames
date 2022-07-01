EnemySmallShip = Class{}

function EnemySmallShip:init(enemyprojectiles)
    self.destTime = 0
    self.isDestroyed = false
    self.type = math.random(1, #gTextures['enemysmallship_body'])

    if self.type == #gTextures['enemysmallship_body'] then
        self.numHit = self.type + 15
    else
        self.numHit = self.type + 10    
    end

    self.enemyprojectiles = enemyprojectiles
    self.interval = math.random(2,3)
    self.counter = 0

    self.remove = false
    self.projecttype = self.type
    self.speed = 40

    self.body = love.graphics.newArrayImage(gTextures['enemysmallship_body'])
    self.body_x = math.random(0 + 200, VIRTUAL_WIDTH - 200)
    self.body_y = VIRTUAL_HEIGHT - 550
    self.body_r = 0

    self.left = love.graphics.newArrayImage(gTextures['enemysmallship_left'])
    self.left_x = self.body_x - 17
    self.left_y = self.body_y
    self.left_r = 0

    self.right = love.graphics.newArrayImage(gTextures['enemysmallship_right'])
    self.right_x = self.body_x - 27
    self.right_y = self.body_y
    self.right_r = 0
end

function EnemySmallShip:update(dt)
    if self.isDestroyed then
        self.destTime = self.destTime + 1 * dt
        if self.destTime > 2 then
            self.remove = true
        end
    end

    -- projectile code ----------------------------------------------
    if self.numHit > 0 then
        self.counter = self.counter + 1 * dt
        if self.counter > self.interval then
            self.runTimer = false
    
            if LASER_MISSLE_SOUND then
                gSounds['laser1']:stop()
                gSounds['laser1']:play()
                gSounds['laser1']:setVolume(0.5)
            end
    
            table.insert(self.enemyprojectiles, EnemyProjectile(2, self.body_x + 17, self.body_y + 10, self.projecttype, 150, PLAYERSHIP_X, PLAYERSHIP_Y))
            self.counter = 0
        end
    end
    -----------------------------------------------------------------
    if self.numHit > 0 then
        self.body_x = math.random(self.body_x - math.random(-0.1, 0.1), self.body_x)
        self.left_x = self.body_x - 17
        self.right_x = self.body_x - 27
    end

    if self.body_y < VIRTUAL_HEIGHT + 110 then
        self.body_y = self.body_y + self.speed * dt
        self.left_y = self.body_y
        self.right_y = self.body_y
    else
        self.remove = true
    end  

    if self.numHit <= 0 then
        if MET_DESTROY_SOUND and not self.isDestroyed then
            gSounds['meteor-explode']:stop()
            gSounds['meteor-explode']:play()
            gSounds['meteor-explode']:setVolume(0.5) 
        end
        
        self.isDestroyed = true
        self.body_r = self.body_r + math.pi/9 * dt
        self.body_x = self.body_x + math.random(10) * dt
        self.body_y = self.body_y + math.random(10) * dt

        self.left_r = self.left_r - math.pi/6 * dt
        self.left_x = self.left_x + math.random(10) * dt
        self.left_y = self.left_y + math.random(10) * dt

        self.right_r = self.right_r - math.pi/8 * dt
        self.right_x = self.right_x + math.random(10) * dt
        self.right_y = self.right_y + math.random(10) * dt
    end
end

function EnemySmallShip:render()
    love.graphics.setColor(1, 0, 0, 1)
    for i = self.numHit * self.type,1 * self.type,-1 do
        do 
            love.graphics.rectangle('fill', self.body_x, self.body_y, i, 2)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.drawLayer(self.body, self.type, self.body_x, self.body_y, self.body_r)
    love.graphics.drawLayer(self.left, self.type, self.left_x, self.left_y, self.left_r)
    love.graphics.drawLayer(self.right, self.type, self.right_x, self.right_y, self.right_r)
end