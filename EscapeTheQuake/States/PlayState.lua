PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player()
    self.brokens = {}
    self.npcs = {}
    self.helpMeter = 0
    self.totalSaved = 0
    self.totalKilled = 0
    self.playerHealth = 5
end

function PlayState:update(dt)
    self.player:update(dt)
    
    -- earthquake time
    if counters[1] > 5 then
        -- for every 1 sec drop a brokenbuild
        if counters[2] >= 1 then
            table.insert(self.brokens, BrokenBuild(self.player.x))
            counters[2] = 0
        end
    end

    if counters[3] > 4 then
        table.insert(self.npcs, NPC(self.player.x))
        table.insert(self.npcs, NPC(self.player.x))
        table.insert(self.npcs, NPC(self.player.x))
        table.insert(self.npcs, NPC(self.player.x))
        table.insert(self.npcs, NPC(self.player.x))
        table.insert(self.npcs, NPC(self.player.x))
        for i = 1, self.totalSaved do
            table.insert(self.npcs, NPC(self.player.x))
            table.insert(self.npcs, NPC(self.player.x))
        end
        counters[3] = 0
    end

    for k, broken in pairs(self.brokens) do
        broken:update(dt)
    end

    for k, npc in pairs(self.npcs) do
        npc:update(dt)
    end

    for k, npc in pairs(self.npcs) do
        if npc.isTraped and npc.countForTrap then
            npc.countForTrap = false
            if npc.x < self.player.x - 150 then
                self.player.totalLeftTraped = self.player.totalLeftTraped + 1
            elseif npc.x > self.player.x + 150 then
                self.player.totalRightTraped = self.player.totalRightTraped + 1
            end
        end
    end

    for k1, broken in pairs(self.brokens) do
        for k2, npc in pairs(self.npcs) do
            if broken.isFalling and npc:collides(broken) then
                if npc.isTraped then
                else
                    if npc.wasHelped then
                    else
                        if counters[5] == 0 then
                            gSounds['man_scream']:stop()
                            gSounds['man_scream']:play()
                        else
                            gSounds['man_scream2']:stop()
                            gSounds['man_scream2']:play()
                        end

                        npc.isTraped = true
                        broken.isFalling = false
                        broken.hasHit = true
                    end
                end
            end
        end
    end

    -- player saves npc from trap
    for k, npc in pairs(self.npcs) do
        if npc.isTraped then
            if npc.wasHelped then
            else
                if npc:collides(self.player) then
                    if love.keyboard.wasPressed('space') then
                        self.helpMeter = self.helpMeter + 1
                        if self.helpMeter > 7 then
                            gSounds['saved_npc']:play()
                            npc.npcWidth = CHARACTER_WIDTH
                            npc.npcHeight = CHARACTER_HEIGHT
                            npc.y = ((8 - 1) * TILE_HEIGHT) - npc.npcHeight
                            npc.isTraped = false
                            npc.wasHelped = true
                            self.helpMeter = 0
                            self.totalSaved = self.totalSaved + 1
                            if self.player.totalTraped > 0 then
                                self.player.totalTraped = self.player.totalTraped - 1
                            end
    
                        end
                    end
                end
            end
        end
    end

    for k, npc in pairs(self.npcs) do
        if npc.wasHelped and (npc.x < self.player.x - 300 or npc.x > self.player.x + 300) then
            table.remove(self.npcs, k)
        end
    end

    for k, npc in pairs(self.npcs) do
        if npc.aliveTimer > 10 then
            if npc.wasHelped then
            else
                if npc.isTraped then
                    if npc.aliveTimer > 15 then
                        -- player was unable to save npc in 20 - 7 secs
                        gSounds['killed']:stop()
                        gSounds['killed']:play()
                        table.remove(self.npcs, k)
                        self.totalKilled = self.totalKilled + 1
                    end
                else
                    table.remove(self.npcs, k)
                end
            end
        end
    end

    for k, broken in pairs(self.brokens) do
        if broken.isFalling == false and broken.hasHit == false and broken.removeTimer > 3 then
            table.remove(self.brokens, k)
        end

        if broken.removeTimerOnHit > 19 then
            table.remove(self.brokens, k)
        end
    end

    for k, broken in pairs(self.brokens) do
        if broken.isFalling and self.player:collides(broken)then
            gSounds['hit_player']:stop()
            gSounds['hit_player']:play()
            table.remove(self.brokens, k) 
            self.playerHealth = self.playerHealth - 1
        end
    end

    if self.playerHealth <= 0 or self.totalKilled > self.totalSaved then
        gStateMachine:change('over', {
            totalSaved = self.totalSaved,
            totalKilled = self.totalKilled,
            PlayerX = self.player.x,
            PlayerY = self.player.y
        })

        self.totalKilled = 0
        self.totalSaved = 0
        self.playerHealth = 5
    end
end

function PlayState:render()
    
    for k, broken in pairs(self.brokens) do
        broken:render()
    end
    
    for k, npc in pairs(self.npcs) do
        npc:render()
    end

    love.graphics.setColor(0, 1, 0, 1)
    for i = self.helpMeter, 1, -1 do
        love.graphics.rectangle("fill", self.player.x, self.player.y - 5, i, 2)
    end

    if camScroll > 0 then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setColor(0,1,0,1)
        love.graphics.setFont(gFonts['small'])
        love.graphics.print(self.totalSaved, math.floor(camScroll + VIRTUAL_WIDTH / 2 - 140), 1)
        love.graphics.setColor(1,0,0,1)
        love.graphics.print(self.totalKilled, math.floor(camScroll+VIRTUAL_WIDTH / 2), 1)
        love.graphics.setColor(0,0,1,1)
        love.graphics.print(self.player.totalTraped, math.floor(camScroll+VIRTUAL_WIDTH / 2 + 140), 1)
        love.graphics.setColor(1,1,1,1)
    
        for i = 1, 5 do
            love.graphics.draw(signSheet, signQuads[4], math.floor(camScroll + VIRTUAL_WIDTH - (i * 12)))
        end

        for i = 1, self.playerHealth do
            love.graphics.draw(signSheet, signQuads[3], math.floor(camScroll + VIRTUAL_WIDTH - (i * 12)))
        end

    else
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setColor(0,1,0,1)
        love.graphics.setFont(gFonts['small'])
        love.graphics.print(self.totalSaved, math.floor(VIRTUAL_WIDTH / 2 - 140), 1)
        love.graphics.setColor(1,0,0,1)
        love.graphics.print(self.totalKilled, math.floor(VIRTUAL_WIDTH / 2), 1)
        love.graphics.setColor(0,0,1,1)
        love.graphics.print(self.player.totalTraped, math.floor(VIRTUAL_WIDTH / 2 + 140), 1)
        love.graphics.setColor(1,1,1,1)
        
        for i = 1, 5 do
            love.graphics.draw(signSheet, signQuads[4], math.floor(VIRTUAL_WIDTH - (i * 12)))
        end

        for i = self.playerHealth, 1, -1 do
            love.graphics.draw(signSheet, signQuads[3], math.floor(VIRTUAL_WIDTH - (i * 12)))
        end

    end
    self.player:render()
end