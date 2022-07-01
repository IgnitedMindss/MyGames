PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.animation = Animation{
        frames = {14},
        interval = 1
    }
    self.player.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    self:PLAYER_CHECK_BOTTOMTILES_AND_MOVEMENT(dt)

    for k, object in pairs(self.player.level.objects) do
        if object:collides(self.player) then
            if object.deadly then
                gSounds['death']:play()
                counters[1] = 0
                counters[3] = 0
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

    -- under construction
    for k, entity in pairs(self.player.level.entities) do
        if entity:collides(self.player) and (self.player.y < entity.y) then
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


function PlayerFallingState:PLAYER_CHECK_BOTTOMTILES_AND_MOVEMENT(dt)
    local _tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
    local _tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

    if(_tileBottomLeft and _tileBottomRight) and (_tileBottomLeft:collidable() or _tileBottomRight:collidable()) then
        self.player.dy = 0

        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walking')
        else
            self.player:changeState('idle')
        end

        self.player.y = (_tileBottomLeft.y - 1) * TILE_SIZE - self.player.height
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