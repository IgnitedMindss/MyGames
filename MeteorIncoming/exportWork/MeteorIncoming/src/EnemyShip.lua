EnemyShip = Class{}

function EnemyShip:init(enemyprojectiles)
    self.destTime = 0
    self.isDestroyed = false

    self.enemyprojectiles = enemyprojectiles
    self.interval = math.random(3,5)
    self.counter = 0

    self.type = math.random(1, #gTextures['enemyship_body'])
    self.projecttype = self.type
    self.remove = false
    self.speed = 30

    if self.type == #gTextures['enemyship_body'] then
        self.numHit = self.type + 15
    else
        self.numHit = self.type + 10    
    end

    self.body = love.graphics.newArrayImage(gTextures['enemyship_body'])
    self.body_x = math.random(0 + 200, VIRTUAL_WIDTH - 200)
    self.body_y = VIRTUAL_HEIGHT - 550
    self.body_r = 0

    self.bottomBody = love.graphics.newArrayImage(gTextures['enemyship_bottomBody'])
    self.bottomBody_x = self.body_x + 33
    self.bottomBody_y = self.body_y + 2
    self.bottomBody_r = 0

    self.upperBody = love.graphics.newArrayImage(gTextures['enemyship_upperBody'])
    self.upperBody_x = self.body_x + 47
    self.upperBody_y = self.body_y + 55
    self.upperBody_r = 0

    self.bottomLeftBlade = love.graphics.newArrayImage(gTextures['enemyship_bottomleftBlade'])
    self.bottomLeftBlade_x = self.body_x + 31
    self.bottomLeftBlade_y = self.body_y - 2
    self.bottomLeftBlade_r = 0

    self.bottomRightBlade = love.graphics.newArrayImage(gTextures['enemyship_bottomrightBlade'])
    self.bottomRightBlade_x = self.body_x + 56
    self.bottomRightBlade_y = self.body_y - 2
    self.bottomRightBlade_r = 0

    self.upperLeftBlade = love.graphics.newArrayImage(gTextures['enemyship_upperleftBlade'])
    self.upperLeftBlade_x = self.body_x + 35
    self.upperLeftBlade_y = self.body_y + 68
    self.upperLeftBlade_r = 0

    self.upperRightBlade = love.graphics.newArrayImage(gTextures['enemyship_upperrightBlade'])
    self.upperRightBlade_x = self.body_x + 57
    self.upperRightBlade_y = self.body_y + 68
    self.upperRightBlade_r = 0

    self.leftWing = love.graphics.newArrayImage(gTextures['enemyship_leftWing'])
    self.leftWing_x = self.body_x + 15
    self.leftWing_y = self.body_y + 19
    self.leftWing_r = 0

    self.rightWing = love.graphics.newArrayImage(gTextures['enemyship_rightWing'])
    self.rightWing_x = self.body_x + 65
    self.rightWing_y = self.body_y + 19
    self.rightWing_r = 0

    self.headLights = love.graphics.newArrayImage(gTextures['enemyship_headLights'])
    self.headLights_x = self.body_x - 6
    self.headLights_y = self.body_y + 28
    self.headLights_r = 0

    self.leftwingleftBlade = love.graphics.newArrayImage(gTextures['enemyship_leftwingleftBlade'])
    self.leftwingleftBlade_x = self.body_x - 6
    self.leftwingleftBlade_y = self.body_y + 28
    self.leftwingleftBlade_r = 0

    self.leftwingrightBlade = love.graphics.newArrayImage(gTextures['enemyship_leftwingrightBlade'])
    self.leftwingrightBlade_x = self.body_x + 12
    self.leftwingrightBlade_y = self.body_y + 28
    self.leftwingrightBlade_r = 0

    self.rightwingleftBlade = love.graphics.newArrayImage(gTextures['enemyship_rightwingleftBlade'])
    self.rightwingleftBlade_x = self.body_x + 78
    self.rightwingleftBlade_y = self.body_y + 28
    self.rightwingleftBlade_r = 0

    self.rightwingrightBlade = love.graphics.newArrayImage(gTextures['enemyship_rightwingrightBlade'])
    self.rightwingrightBlade_x = self.body_x + 96
    self.rightwingrightBlade_y = self.body_y + 28
    self.rightwingrightBlade_r = 0

    self.leftbWing = love.graphics.newArrayImage(gTextures['enemyship_leftbWing'])
    self.leftbWing_x = self.body_x + 4
    self.leftbWing_y = self.body_y
    self.leftbWing_r = 0

    self.rightbWing = love.graphics.newArrayImage(gTextures['enemyship_rightbWing'])
    self.rightbWing_x = self.body_x + 87
    self.rightbWing_y = self.body_y
    self.rightbWing_r = 0
end

function EnemyShip:update(dt)
    if self.isDestroyed then
        self.destTime = self.destTime + 1 * dt
        if self.destTime > 2 then
            self.remove = true
        end
    end

    -- projectile code ------------------------------------------------------
    self.counter = self.counter + 1 * dt
    if self.counter > self.interval and self.numHit > 0 then
        self.runTimer = false

        if LASER_MISSLE_SOUND then
            gSounds['laser1']:stop()
            gSounds['laser1']:play()
            gSounds['laser1']:setVolume(0.5)
        end

        table.insert(self.enemyprojectiles, EnemyProjectile(1, self.upperLeftBlade_x + 6, self.upperLeftBlade_y + 2, self.projecttype, 150, PLAYERSHIP_X, PLAYERSHIP_Y))
        self.counter = 0
    end

    -------------------------------------------------------------------------
    if self.numHit > 0 then
        self.body_x = math.random(self.body_x - math.random(-0.1, 0.1), self.body_x)
        self.bottomBody_x = self.body_x + 33
        self.upperBody_x = self.body_x + 47
        self.bottomLeftBlade_x = self.body_x + 31
        self.bottomRightBlade_x = self.body_x + 56
        self.upperLeftBlade_x = self.body_x + 35
        self.upperRightBlade_x = self.body_x + 57
        self.leftWing_x = self.body_x + 15
        self.rightWing_x = self.body_x + 65
        self.headLights_x = self.body_x - 6
        self.leftwingleftBlade_x = self.body_x - 6
        self.leftwingrightBlade_x = self.body_x + 12
        self.rightwingleftBlade_x = self.body_x + 78
        self.rightwingrightBlade_x = self.body_x + 96
        self.leftbWing_x = self.body_x + 4
        self.rightbWing_x = self.body_x + 87
    end

    if self.body_y < VIRTUAL_HEIGHT + 110 then
        self.body_y = self.body_y + self.speed * dt
        self.bottomBody_y = self.body_y + 2
        self.bottomBody_y = self.body_y + 2
        self.upperBody_y = self.body_y + 55
        self.bottomLeftBlade_y = self.body_y - 2
        self.bottomRightBlade_y = self.body_y - 2
        self.upperLeftBlade_y = self.body_y + 68
        self.upperRightBlade_y = self.body_y + 68
        self.leftWing_y = self.body_y + 19
        self.rightWing_y = self.body_y + 19
        self.headLights_y = self.body_y + 28
        self.leftwingleftBlade_y = self.body_y + 28
        self.leftwingrightBlade_y = self.body_y + 28
        self.rightwingleftBlade_y = self.body_y + 28
        self.rightwingrightBlade_y = self.body_y + 28
        self.leftbWing_y = self.body_y
        self.rightbWing_y = self.body_y
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
        self.bottomBody_r = self.bottomBody_r + math.pi/9 * dt
        self.bottomBody_x = self.bottomBody_x + math.random(10) * dt
        self.bottomBody_y = self.bottomBody_y + math.random(10) * dt

        self.upperBody_r = self.upperBody_r - math.pi/9 * dt
        self.upperBody_x = self.upperBody_x + math.random(10) * dt
        self.upperBody_y = self.upperBody_y + math.random(10) * dt

        self.bottomLeftBlade_r = self.bottomLeftBlade_r + math.pi/5 * dt
        self.bottomLeftBlade_x = self.bottomLeftBlade_x + math.random(10) * dt
        self.bottomLeftBlade_y = self.bottomLeftBlade_y + math.random(10) * dt

        self.bottomRightBlade_r = self.bottomRightBlade_r - math.pi/7 * dt
        self.bottomRightBlade_x = self.bottomRightBlade_x + math.random(10) * dt
        self.bottomRightBlade_y = self.bottomRightBlade_y + math.random(10) * dt

        self.upperRightBlade_r = self.upperRightBlade_r + math.pi/7 * dt
        self.upperRightBlade_x = self.upperRightBlade_x + math.random(10) * dt
        self.upperRightBlade_y = self.upperRightBlade_y + math.random(10) * dt

        self.upperLeftBlade_r = self.upperLeftBlade_r - math.pi/7 * dt
        self.upperLeftBlade_x = self.upperLeftBlade_x + math.random(10) * dt
        self.upperLeftBlade_y = self.upperLeftBlade_y + math.random(10) * dt

        self.leftWing_r = self.leftWing_r + math.pi/10 * dt
        self.leftWing_x = self.leftWing_x + math.random(10) * dt
        self.leftWing_y = self.leftWing_y + math.random(10) * dt

        self.rightWing_r = self.rightWing_r - math.pi/7 * dt
        self.rightWing_x = self.rightWing_x + math.random(10) * dt
        self.rightWing_y = self.rightWing_y + math.random(10) * dt

        self.leftwingleftBlade_r = self.leftwingleftBlade_r - math.pi/7 * dt
        self.leftwingleftBlade_x = self.leftwingleftBlade_x + math.random(10) * dt
        self.leftwingleftBlade_y = self.leftwingleftBlade_y + math.random(10) * dt

        self.leftwingrightBlade_r = self.leftwingrightBlade_r + math.pi/9 * dt
        self.leftwingrightBlade_x = self.leftwingrightBlade_x + math.random(10) * dt
        self.leftwingrightBlade_y = self.leftwingrightBlade_y + math.random(10) * dt

        self.rightwingleftBlade_r = self.rightwingleftBlade_r - math.pi/7 * dt
        self.rightwingleftBlade_x = self.rightwingleftBlade_x + math.random(10) * dt
        self.rightwingleftBlade_y = self.rightwingleftBlade_y + math.random(10) * dt

        self.rightwingrightBlade_r = self.rightwingrightBlade_r + math.pi/9 * dt
        self.rightwingrightBlade_x = self.rightwingrightBlade_x + math.random(10) * dt
        self.rightwingrightBlade_y = self.rightwingrightBlade_y + math.random(10) * dt

        self.leftbWing_r = self.leftbWing_r - math.pi/6 * dt
        self.leftbWing_x = self.leftbWing_x + math.random(10) * dt
        self.leftbWing_y = self.leftbWing_y + math.random(10) * dt

        self.rightbWing_r = self.rightbWing_r + math.pi/10 * dt
        self.rightbWing_x = self.rightbWing_x + math.random(10) * dt
        self.rightbWing_y = self.rightbWing_y + math.random(10) * dt
    end
end

function EnemyShip:render()
    love.graphics.setColor(1, 0, 0, 1)
    for i = self.numHit * self.type,1 * self.type,-1 do
        do 
            love.graphics.rectangle('fill', self.body_x + 20, self.body_y - 10, i, 2)
        end
    end
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.drawLayer(self.leftWing, self.type, self.leftWing_x, self.leftWing_y, self.leftWing_r)
    love.graphics.drawLayer(self.rightWing, self.type, self.rightWing_x, self.rightWing_y, self.rightWing_r)
    if self.numHit > 0 then
        love.graphics.drawLayer(self.body, self.type, self.body_x, self.body_y, self.body_r)
    end
    love.graphics.drawLayer(self.bottomLeftBlade, self.type, self.bottomLeftBlade_x, self.bottomLeftBlade_y, self.bottomLeftBlade_r)
    love.graphics.drawLayer(self.bottomRightBlade, self.type, self.bottomRightBlade_x, self.bottomRightBlade_y, self.bottomRightBlade_r)
    love.graphics.drawLayer(self.upperLeftBlade, self.type, self.upperLeftBlade_x, self.upperLeftBlade_y, self.upperLeftBlade_r)
    love.graphics.drawLayer(self.upperRightBlade, self.type, self.upperRightBlade_x, self.upperRightBlade_y, self.upperRightBlade_r)
    love.graphics.drawLayer(self.bottomBody, self.type, self.bottomBody_x, self.bottomBody_y, self.bottomBody_r)
    love.graphics.drawLayer(self.upperBody, self.type, self.upperBody_x, self.upperBody_y, self.upperBody_r)
    love.graphics.drawLayer(self.leftwingleftBlade, self.type, self.leftwingleftBlade_x, self.leftwingleftBlade_y, self.leftwingleftBlade_r)
    love.graphics.drawLayer(self.leftwingrightBlade, self.type, self.leftwingrightBlade_x, self.leftwingrightBlade_y, self.leftwingrightBlade_r)
    love.graphics.drawLayer(self.rightwingleftBlade, self.type, self.rightwingleftBlade_x, self.rightwingleftBlade_y, self.rightwingleftBlade_r)
    love.graphics.drawLayer(self.rightwingrightBlade, self.type, self.rightwingrightBlade_x, self.rightwingrightBlade_y, self.rightwingrightBlade_r)
    love.graphics.drawLayer(self.leftbWing, self.type, self.leftbWing_x, self.leftbWing_y, self.leftbWing_r)
    love.graphics.drawLayer(self.rightbWing, self.type, self.rightbWing_x, self.rightbWing_y, self.rightbWing_r)
    if self.numHit > 0 then
        love.graphics.drawLayer(self.headLights, self.type, self.headLights_x, self.headLights_y, self.headLights_r)
    end
end