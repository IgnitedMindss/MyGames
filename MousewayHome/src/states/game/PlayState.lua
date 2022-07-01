PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.bestTimers = params.bestTimers
    self.curr_level = params.curr_level

    self.camX = 0
    self.camY = 0
    self.level = LevelMaker.generateLevel(490, 220, self.curr_level)
    self.tilemap = self.level.tilemap


    self.player_x = {0,0,50,430,430}
    self.player_y = {0,0,50,100,100}

    self.smoke_x = {0,0,5,39,39}
    self.smoke_y = {0,0,4,8,8}

    self.switch_status_levelwise = {false, false, false, true, false}
    self.switch_posX = {0, 0, 0, 6, 0}
    self.switch_posY = {0, 0, 0, 17, 0}

    self.backgroundX = 0

    self.gravityOn = true
    self.gravityAmount = 10

    self.player = Player({
        x = self.player_x[self.curr_level], y = self.player_y[self.curr_level],
        width = 21, height = 21,
        texture = 'player',
        stateMachine = StateMachine{
            ['idle'] = function ()
                return PlayerIdleState(self.player)
            end,
            ['walking'] = function ()
                return PlayerWalkingState(self.player)
            end,
            ['jump'] = function ()
                return PlayerJumpState(self.player, self.gravityAmount)
            end,
            ['falling'] = function ()
                return PlayerFallingState(self.player, self.gravityAmount)
            end,
            ['double-jump'] = function ()
                return PlayerDoubleJumpState(self.player, self.gravityAmount)
            end
        },
        map = self.tilemap,
        level = self.level,
        bestTimers = self.bestTimers,
        curr_level = self.curr_level
    })

    self:spawnEnemies()
    self:smokeEffect()
    self.player:changeState('falling')

end

function PlayState:update(dt)
    Timer.update(dt)

    self.player:update(dt)
    self.level:update(dt)

    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > TILE_SIZE * self.tilemap.width - self.player.width then
        self.player.x = TILE_SIZE * self.tilemap.width - self.player.width
    end

    self:updateCamera()

    if love.keyboard.wasPressed("escape") then
        gStateMachine:change("start", {
            bestTimers = self.bestTimers
        })
    end
end

function PlayState:render()
    love.graphics.push()

    self.level:render()
    self.player:render()
    love.graphics.pop()

    -- timer
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 8, 1, 490, 7)
    love.graphics.setColor(1, 1, 1, 1)
    
    love.graphics.print("Total time: " ..self.player.mintimer.." : ".. tostring(self.player.timer), 400, 1)

    -- best timer
    local name = self.bestTimers[self.curr_level].name
    local min = self.bestTimers[self.curr_level].min
    local sec = self.bestTimers[self.curr_level].sec

    love.graphics.print("Best time: " .. name .. " : " .. min .." min " .. sec .. " sec ", 10, 1)

    local dash_status = ''
    if counters[1] <= 2 then
        dash_status = "Dash: Recharging..."
    else
        dash_status = "Dash: Recharged"
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 8, 210, 80, 7)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(dash_status , 10, 210)
end

function PlayState:updateCamera()
    self.camX = math.max(0, math.min(TILE_SIZE * self.tilemap.width - VIRTUAL_WIDTH, self.player.x - (VIRTUAL_WIDTH / 2 - 8)))

    self.backgroundX = (self.camX / 3) % 256
end

function PlayState:spawnEnemies()

    if self.curr_level == 1 then
        local eagle
        eagle = Eagle{
            texture = 'eagle',
            x = (31 - 1) * TILE_SIZE, y = (10 - 1) * TILE_SIZE,
            width = 36, height = 41,
            stateMachine = StateMachine {
                ['moving'] = function ()
                    return EagleMovingState(self.tilemap, self.player, eagle)
                end
            }
        }
        eagle:changeState('moving')
        table.insert(self.level.entities, eagle)
    elseif self.curr_level == 2 then
        local eagle
        eagle = Eagle{
        texture = 'eagle',
        x = (14 - 1) * TILE_SIZE, y = (6 - 1) * TILE_SIZE,
        width = 36, height = 41,
        stateMachine = StateMachine {
            ['moving'] = function ()
                return EagleMovingState(self.tilemap, self.player, eagle)
            end
             }
        }
        eagle:changeState('moving')
        table.insert(self.level.entities, eagle)
    elseif self.curr_level == 3 then
        local frog
        frog = Frog{
            texture = 'frog-idle',
            x = (24 - 1) * TILE_SIZE, y = (10 - 1) * TILE_SIZE,
            width = 31, height = 22,
            stateMachine = StateMachine {
                ['idle'] = function ()
                    frog.texture = 'frog-idle'
                    return FrogIdleState(self.tilemap, self.player, frog)
                end,
                ['moving'] = function ()
                    frog.texture = 'frog-run'
                    return FrogMovingState(self.tilemap, self.player, frog)
                end
            }
        }
        frog:changeState('moving')
        table.insert(self.level.entities, frog)
    elseif self.curr_level == 4 then
        local frog1
        local frog2
        local eagle
        frog1 = Frog{
            texture = 'frog-idle',
            x = (30 - 1) * TILE_SIZE, y = (10 - 1) * TILE_SIZE,
            width = 31, height = 22,
            stateMachine = StateMachine {
                ['idle'] = function ()
                    frog1.texture = 'frog-idle'
                    return FrogIdleState(self.tilemap, self.player, frog1)
                end,
                ['moving'] = function ()
                    frog1.texture = 'frog-run'
                    return FrogMovingState(self.tilemap, self.player, frog1)
                end
            }
        }
    
        frog1:changeState('idle')
    
        frog2 = Frog{
            texture = 'frog-idle',
            x = (20 - 1) * TILE_SIZE, y = (10 - 1) * TILE_SIZE,
            width = 31, height = 22,
            stateMachine = StateMachine {
                ['idle'] = function ()
                    frog2.texture = 'frog-idle'
                    return FrogIdleState(self.tilemap, self.player, frog2)
                end,
                ['moving'] = function ()
                    frog2.texture = 'frog-run'
                    return FrogMovingState(self.tilemap, self.player, frog2)
                end
            }
        }
    
        frog2:changeState('idle')
    
        eagle = Eagle{
            texture = 'eagle',
            x = (20 - 1) * TILE_SIZE, y = (2 - 1) * TILE_SIZE,
            width = 36, height = 41,
            stateMachine = StateMachine {
                ['moving'] = function ()
                    return EagleMovingState(self.tilemap, self.player, eagle)
                end
            }
        }
        eagle:changeState('moving')
        table.insert(self.level.entities, eagle)
        table.insert(self.level.entities, frog1)
        table.insert(self.level.entities, frog2)
    elseif self.curr_level == 5 then
        local eagle1
        local eagle2
        eagle1 = Eagle{
            texture = 'eagle',
            x = (13 - 1) * TILE_SIZE, y = (7 - 1) * TILE_SIZE,
            width = 36, height = 41,
            stateMachine = StateMachine {
                ['moving'] = function ()
                    return EagleMovingState(self.tilemap, self.player, eagle1)
                end
            }
        }
        eagle1:changeState('moving')
        table.insert(self.level.entities, eagle1)

        eagle2 = Eagle{
            texture = 'eagle',
            x = (32 - 1) * TILE_SIZE, y = (7 - 1) * TILE_SIZE,
            width = 36, height = 41,
            stateMachine = StateMachine {
                ['moving'] = function ()
                    return EagleMovingState(self.tilemap, self.player, eagle2)
                end
            }
        }
        eagle2:changeState('moving')
        table.insert(self.level.entities, eagle2)
    end
end

function PlayState:smokeEffect()
    table.insert(self.level.objects, 
        GameObject{
            texture = 'smoke',
            x = (self.smoke_x[self.curr_level] - 1) * TILE_SIZE, y = (self.smoke_y[self.curr_level] - 1) * TILE_SIZE,
            width = 41, height = 41,
            frame = {1,2,3,4,5,6},
        }
    )
end