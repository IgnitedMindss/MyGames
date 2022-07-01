Tile = Class{}

function Tile:init(x, y, id)
    self.x = x
    self.y = y

    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.id = id
end

function Tile:collidable(target)
    for k, id in pairs(COLLIDABLE_TILES) do
        if id == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(tilesheet, quads[self.id], (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end
