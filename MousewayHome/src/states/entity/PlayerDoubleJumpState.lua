PlayerDoubleJumpState = Class{__includes = BaseState}

function PlayerDoubleJumpState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.animation = Animation{
        frames = {13},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerDoubleJumpState:enter(params)
    gSounds['jump']:stop()
    gSounds['jump']:play()
    self.player.dy = PLAYER_JUMP_VELOCITY
end

function PlayerDoubleJumpState:update(dt)
    self.player.currentAnimation:update(dt)

    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    if self.player.dy >= 0 then
        self.player:changeState('falling')
    end

    self.player.y = self.player.y + (self.player.dy * dt)

    self:PLAYER_CHECK_UPPERTILES_AND_MOVEMENT_FALLING(dt)

    for k, object in pairs(self.player.level.objects) do
        if object:collides(self.player) then
            if object.deadly then
                gSounds['death']:play()
                counters[3] = 0
                counters[1] = 0
                self.player.gemcollected = false
                gStateMachine:change('play', {
                    bestTimers = self.player.bestTimers,
                    curr_level = self.player.curr_level 
                })
            elseif object.consumable then
                gSounds['pickup']:play()
                table.remove(self.player.level.objects, k)
                self.player.gemcollected = true
            elseif object.switch then
                object.frame = 2
            end
        end
    end

    for k, entity in pairs(self.player.level.entities) do
        if entity:collides(self.player) then
                gSounds['death']:play()
                counters[1] = 0
                counters[3] = 0
                self.player.gemcollected = false
                gStateMachine:change('play', {
                    bestTimers = self.player.bestTimers,
                    curr_level = self.player.curr_level 
                })
        end
    end

    if love.keyboard.wasPressed('d') and counters[1] > 2 then
        counters[1] = 0
        if self.player.direction == 'right' then
            Timer.tween(0.1, {
                [self.player] = {x = (self.player.x + PLAYER_DASH)}
            })        
        else
            Timer.tween(0.1, {
                [self.player] = {x = (self.player.x - PLAYER_DASH)}
            })    
        end
    end
end

function PlayerDoubleJumpState:PLAYER_CHECK_UPPERTILES_AND_MOVEMENT_FALLING(dt)
    local _tileUpperLeft = self.player.map:pointToTile(self.player.x + 3, self.player.y)
    local _tileUpperRight = self.player.map:pointToTile(self.player.x + self.player.width - 3, self.player.y)

    if(_tileUpperLeft and _tileUpperRight) and (_tileUpperLeft:collidable() or _tileUpperRight:collidable()) then
        self.player.dy = 0
        self.player:changeState('falling')
    elseif love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        self.player:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        self.player:checkRightCollisions(dt)
    end

end