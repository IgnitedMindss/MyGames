PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
    self.player = player
    self.animation = Animation{
        frames = {5, 6, 7, 8, 9, 10},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
    self.player.currentAnimation:update(dt)

    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        self.player:changeState('idle')
    else
        self:PLAYER_CHECK_BOTTOMTILES_AND_MOVEMENT_FALLING(dt)
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('jump')
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
            elseif object.ishome then
                -- complete level
                    gSounds['death']:play()
                    counters[1] = 0
                    gStateMachine:change('enter-time',{
                        gemcollected = self.player.gemcollected,
                        bestTimers = self.player.bestTimers,
                        curr_level = self.player.curr_level,
                        min = self.player.mintimer,
                        sec = self.player.timer
                    })
            elseif object.switch then
                object.frame = 2
            end
        end
    end

    -- for k, object in pairs(self.player.level.objects) do
    --     if object:collides(self.player) then
    --         if(object.switch)then
    --             if object.frame == 1 then
    --                 -- table.insert(self.player.level.tilemap.tiles[self.player.switch_posY[self.player.curr_level]],
    --                 --     Tile(self.player.switch_posX[self.player.curr_level], self.player.switch_posY[self.player.curr_level], math.random(1, 3)))
    --                     -- self.player.switch_status_levelwise[self.player.curr_level] = false
    --             end
    --         end
    --     end
    -- end

    for k, entity in pairs(self.player.level.entities) do
        if entity:collides(self.player) then
                gSounds['death']:play()
                counters[3] = 0
                counters[1] = 0
                self.player.gemcollected = false
                gStateMachine:change('play', {
                    bestTimers = self.player.bestTimers,
                    curr_level = self.player.curr_level 
                })
        end
    end

end


function PlayerWalkingState:PLAYER_CHECK_BOTTOMTILES_AND_MOVEMENT_FALLING(dt)
    local _tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
    local _tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

        if (_tileBottomLeft and _tileBottomRight) and 
        (not _tileBottomLeft:collidable() and not _tileBottomRight:collidable()) then
            self.player.dy = 0
            self.player:changeState('falling')
        elseif love.keyboard.isDown('left') then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
            self.player.direction = 'left'
            self.player:checkLeftCollisions(dt)
        elseif love.keyboard.isDown('right') then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
            self.player.direction = 'right'
            self.player:checkRightCollisions(dt)
        end
end