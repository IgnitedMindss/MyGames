FrogMovingState = Class{__includes = BaseState}

function FrogMovingState:init(tilemap, player, frog)
    self.tilemap = tilemap
    self.player = player
    self.frog = frog

    self.animation = Animation{
        frames = {1, 2},
        interval = 0.3
    }
    self.frog.currentAnimation = self.animation
    self.moveLeft = true
    self.frog_x = self.frog.x
end

function FrogMovingState:update(dt)
    self.frog.currentAnimation:update(dt)

    if self.moveLeft then
        self.frog.direction = 'left'
        self:MoveLeft(dt)
    else
        self.frog.direction = 'right'
        self:MoveRight(dt)
    end
end

function FrogMovingState:MoveLeft(dt)
    if self.frog.x > self.frog_x - 100 then
        self.frog.x = self.frog.x - FROG_MOVING_SPEED * dt
    else
        self.moveLeft = false
    end
end

function FrogMovingState:MoveRight(dt)
    if self.frog.x < self.frog_x + 50 then
        self.frog.x = self.frog.x + FROG_MOVING_SPEED * dt
    else
        self.moveLeft = true
    end
end