EnemyProjectile = Class{}

function EnemyProjectile:init(enemyType, x,y,type,speed, speedx, speedy)
    self.enemyType = enemyType
    if self.enemyType == 1 then
        self.laser = love.graphics.newArrayImage(gTextures['enemyLasers'])
    else
        self.laser = love.graphics.newArrayImage(gTextures['smallenemyLasers'])
    end
    self.laserType = type
    self.laserSpeed = speed
    self.x = x
    self.y = y
    self.width = 20
    self.height = 20
    self.remove = false
    self.speedx = math.abs(speedx)/5
    self.speedy = math.abs(speedy)/3
end

function EnemyProjectile:update(dt)
    if self.enemyType == 1 then
        if self.y > -self.width and self.y < VIRTUAL_HEIGHT + 110 then
            self.y = self.y + self.speedy * dt
            if PLAYERSHIP_X > self.x then
                self.x = self.x + self.speedx * dt
            else
                self.x = self.x - self.speedx * dt
            end
        else
            self.remove = true
        end
    else
        if self.y < VIRTUAL_HEIGHT + 110 then
            self.y = self.y + self.laserSpeed * dt
        else
            self.remove = true
        end  
    end

end

function EnemyProjectile:collides(target)
    if self.x > target.body_x + target.body_width or target.body_x > self.x + self.width then
        return false
    end

    if self.y > target.body_y + target.body_height or target.body_y > self.y + self.height then
        return false
    end

    return true
end

function EnemyProjectile:render()
    love.graphics.drawLayer(self.laser, self.laserType, self.x, self.y)
end