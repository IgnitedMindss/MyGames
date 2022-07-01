FrogIdleState = Class{__includes = BaseState}

function FrogIdleState:init(tilemap, player, frog)
    self.tilemap = tilemap
    self.player = player
    self.frog = frog

    self.animation = Animation{
        frames = {1,2,3,4},
        interval = 0.3
    }
    self.frog.currentAnimation = self.animation
end

function FrogIdleState:update(dt)
    self.frog.currentAnimation:update(dt)

    local diffX = math.abs(self.player.x - self.frog.x)

    if diffX < 8 * TILE_SIZE then
        self.frog.width = 34
        self.frog.height = 32
        self.frog.y = self.frog.y - TILE_SIZE
        self.frog:changeState('moving')
    end
end