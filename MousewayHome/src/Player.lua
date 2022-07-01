Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.timer = 0
    self.mintimer = 0

    self.switch_status_levelwise = {false, false, false, true, false}
    self.switch_posX = {0, 0, 0, 6, 0}
    self.switch_posY = {0, 0, 0, 17, 0}
end

function Player:update(dt)
    Entity.update(self, dt)
    self.timer = counters[3]
    if counters[3] >= 60 then
        self.mintimer = self.mintimer + 1
        counters[3] = 0
    end
end

function Player:render()
    Entity.render(self)
end

function Player:checkLeftCollisions(dt)
    local _tileTopLeft = self.map:pointToTile(self.x + 1, self.y + 1)
    local _tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height - 1)

    if (_tileTopLeft and _tileBottomLeft) and (_tileTopLeft:collidable() or _tileBottomLeft:collidable()) then
        self.x = (_tileTopLeft.x - 1) * TILE_SIZE + _tileTopLeft.width - 1
    end
end


function Player:checkRightCollisions(dt)
    local _tileTopRight = self.map:pointToTile(self.x + self.width - 1, self.y + 1)
    local _tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    if (_tileTopRight and _tileBottomRight) and (_tileTopRight:collidable() or _tileBottomRight:collidable()) then
        self.x = (_tileTopRight.x - 1) * TILE_SIZE - self.width
    end
end

