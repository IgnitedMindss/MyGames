Guide = Class{}

function Guide:init()
    self.c1 = false
    self.c2 = false
    self.c3 = false
    self.c4 = false
    self.ammo2 = false
    self.ammo3 = false
    self.ammo4 = false
    self.isbot = false
    self.meteorCome = true
    self.isLeft = true
    self.isRight = true
    self.isSpace = true
    self.remGuideTemp = true
    self.remGuide = false
end

function Guide:update(dt)
    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a') then
        self.isLeft = false
    end

    if love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d') then
        self.isRight = false
    end

    if love.keyboard.wasPressed('space') then
        self.isSpace = false
    end

    if self.remGuideTemp then
        if (not self.isLeft and not self.isRight) and not self.isSpace then
            self.meteorCome = false
            self.remGuide = true
        end
    end

    if not self.remGuide then
        counters[8] = 0
    end
    
    if self.remGuide then
        if counters[8] >= intervals[8] then
            self.remGuide = false
            self.remGuideTemp = false
        end
    end

    if not self.ammo2 then
        counters[9] = 0
    end

    if self.ammo2 then
        if counters[9] >= intervals[9] then
            self.ammo2 = false
        end
    end

    if not self.ammo3 then
        counters[10] = 0
    end

    if self.ammo3 then
        if counters[10] >= intervals[10] then
            self.ammo3 = false
        end
    end

    if not self.ammo4 then
        counters[11] = 0
    end

    if self.ammo4 then
        if counters[11] >= intervals[11] then
            self.ammo4 = false
        end
    end

    if not self.isbot then
        counters[12] = 0
    end

    if self.isbot then
        if counters[12] >= intervals[12] then
            self.isbot = false
        end
    end

    if not self.c1 then
        counters[13] = 0
    end

    if self.c1 then
        if counters[13] >= intervals[13] then
            self.c1 = false
        end
    end

    if not self.c2 then
        counters[14] = 0
    end

    if self.c2 then
        if counters[14] >= intervals[14] then
            self.c2 = false
        end
    end

    if not self.c3 then
        counters[15] = 0
    end

    if self.c3 then
        if counters[15] >= intervals[15] then
            self.c3 = false
        end
    end

    if not self.c4 then
        counters[16] = 0
    end

    if self.c4 then
        if counters[16] >= intervals[16] then
            self.c4 = false
        end
    end
end

function Guide:render()
    if self.isLeft then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' <- key \' or \' A \' to move left', 0, VIRTUAL_HEIGHT/2 - 100, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.isRight then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' -> key \' or \' D \' to move right', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.isSpace then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' space \' to shoot', 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.remGuide then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('You can always turn off the GUIDE in Settings :)', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.ammo2 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' 2 \' to activate 2nd missles', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.ammo3 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' 3 \' to activate 3nd missles', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.ammo4 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' 4 \' to activate the lasers', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.isbot then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' G \' to deploy helper bot', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.c1 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' H \' to heal earth\'s health', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.c2 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' J \' to use shield', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.c3 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' K \' to increase fire power', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.c4 then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.printf('Press \' L \' to increase speed of playership', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH/2 + 380, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end
end

