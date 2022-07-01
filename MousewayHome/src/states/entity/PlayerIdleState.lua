PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player

    self.animation = Animation{
        frames = {1, 2, 3, 4},
        interval = 0.1
    }

    self.player.currentAnimation = self.animation
end


function PlayerIdleState:update(dt)
    self.player.currentAnimation:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.player:changeState('walking')
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
            elseif object.switch then
                object.frame = 2
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

    self:PLAYER_CHECK_BOTTOMTILES(dt)
end

function PlayerIdleState:PLAYER_CHECK_BOTTOMTILES(dt)
    local _tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
    local _tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

        if (_tileBottomLeft and _tileBottomRight) and 
        (not _tileBottomLeft:collidable() and not _tileBottomRight:collidable()) then
            self.player.dy = 0
            self.player:changeState('falling')
        end
end