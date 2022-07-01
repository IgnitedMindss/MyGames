BrokenBuild = Class{}

function BrokenBuild:init(playerX)
    self.brokensSheet = love.graphics.newImage('Assets/BrokenBuilds/brokens.png')
    self.brokenQuads = GenerateQuads(self.brokensSheet, 49, 51)
    self.x = math.random(playerX - 400, playerX + 400)
    self.y = VIRTUAL_HEIGHT - 300
    self.type = math.random(3)
    self.speed = 150
    self.width = 49
    self.height = 51
    self.isFalling = true
    self.hasHit = false
    self.removeTimer = 0
    self.removeTimerOnHit = 0
end

function BrokenBuild:update(dt)
    if self.y < ((8 - 1) * TILE_HEIGHT) - self.height then
        self.y = self.y + self.speed * dt
    end

    if self.y >= ((8 - 1) * TILE_HEIGHT) - self.height then
        if self.hasHit == false then
            self.removeTimer = self.removeTimer + dt
        end
        self.isFalling = false
    end
    self.removeTimerOnHit = self.removeTimerOnHit + dt
end

function BrokenBuild:render()
    love.graphics.draw(self.brokensSheet, self.brokenQuads[self.type], self.x, self.y)
    -- debug
    -- love.graphics.setColor(1,0,1,1)
    -- love.graphics.print(self.removeTimer, self.x, self.y)
    -- love.graphics.print(self.isFalling == true and "fall: true" or "fall:false", self.x, self.y+8)
    -- love.graphics.print(self.hasHit == true and "hit: true" or "hit:false", self.x, self.y+16)
    -- love.graphics.setColor(1,1,1,1)
end