EagleMovingState = Class{__includes = BaseState}

function EagleMovingState:init(tilemap, player, eagle)
    self.tilemap = tilemap
    self.player = player
    self.eagle = eagle

    self.animation = Animation{
        frames = {1, 2, 3, 4},
        interval = 0.3
    }
    self.eagle.currentAnimation = self.animation
    self.moveLeft = true
    self.eagle_x = self.eagle.x
end

function EagleMovingState:update(dt)
    self.eagle.currentAnimation:update(dt)

    if self.moveLeft then
        self.eagle.direction = 'left'
        self:MoveLeft(dt)
    else
        self.eagle.direction = 'right'
        self:MoveRight(dt)
    end
end

function EagleMovingState:MoveLeft(dt)
    if self.eagle.x > self.eagle_x - 50 then
        self.eagle.x = self.eagle.x - EAGLE_MOVING_SPEED * dt
    else
        self.moveLeft = false
    end
end

function EagleMovingState:MoveRight(dt)
    if self.eagle.x < self.eagle_x + 50 then
        self.eagle.x = self.eagle.x + EAGLE_MOVING_SPEED * dt
    else
        self.moveLeft = true
    end
end