Projectile = Class{}

local paletteColors = {
    -- red
    [1] = {
        ['r'] = 0.85,
        ['g'] = 0.34,
        ['b'] = 0.38
    },
    -- green
    [2] = {
        ['r'] = 0.41,
        ['g'] = 0.74,
        ['b'] = 0.18
    },
    --blue
    [3] = {
        ['r'] = 0.38,
        ['g'] = 0.6,
        ['b'] = 1
    },
    -- gold
    [4] = {
        ['r'] = 0.98,
        ['g'] = 0.94,
        ['b'] = 0.21
    }
}

function Projectile:init(x,y,type,speed)
    self.laser = love.graphics.newArrayImage(gTextures['lasers'])
    self.laserType = type
    self.laserSpeed = speed
    self.x = x
    self.y = y
    self.width = 5
    self.height = 17
    self.remove = false
    self.isParticle = false

    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)

    -- self.psystem:setParticleLifetime(3.93)

    -- self.psystem:setEmissionArea('normal', 13.33, 13.33)

    -- self.psystem:setEmissionRate(2200.00)

    -- self.psystem:setSizes(0.80, 3.37, 5.00)

    -- self.psystem:setSizeVariation(0.23)

    -- self.psystem:setDirection(0)

    self.psystem:setRadialAcceleration(146.67)

    self.psystem:setSpread(3.28)

    -- self.psystem:setLinearDamping(0.73)

    self.psystem:setSpin(17.20)

    -- self.psystem:setTangentialAcceleration(20.00)

    self.psystem:setParticleLifetime(3)

    self.psystem:setSizes(0.4, 0.8, 0.5)

    --self.psystem:setLinearAcceleration(-15, 0, 15, 80)

    self.psystem:setEmissionArea('borderellipse', 20, 20, 5)
end

function Projectile:update(dt)
    self.psystem:update(dt)

    if self.y > -self.width then
        self.y = self.y + self.laserSpeed * dt
    else
        self.remove = true
    end
end

function Projectile:hit()
    self.psystem:setColors(
        paletteColors[self.laserType].r,
        paletteColors[self.laserType].g,
        paletteColors[self.laserType].b,
        55 * (self.laserType + 1),
        paletteColors[self.laserType].r,
        paletteColors[self.laserType].g,
        paletteColors[self.laserType].b,
        0
    )

    self.psystem:emit(32)
    self.remove = true
    self.isParticle = true

end

function Projectile:collides(target)
    if target.r == 0 then
        if self.x > target.x + target.width or target.x > self.x + self.width then
            return false
        end
    
        if self.y > target.y + target.height or target.y > self.y + self.height then
            return false
        end
    
        return true
    end

    if target.r > 0 then
        if self.x - self.width > target.x + target.width or target.x > self.x + self.width then
            return false
        end
    
        if self.y > target.y + target.height or target.y > self.y + self.height then
            return false
        end
    
        return true
    end

    if target.r < 0 then
        if self.x > target.x + target.width or target.x > self.x + self.width then
            return false
        end
    
        if self.y > target.y or target.y > self.y + self.height then
            return false
        end
    
        return true
    end
end

function Projectile:render()
    love.graphics.drawLayer(self.laser, self.laserType, self.x, self.y)
end

function Projectile:renderParticles()
    if self.isParticle then
        love.graphics.draw(self.psystem, self.x, self.y) 
    end
end