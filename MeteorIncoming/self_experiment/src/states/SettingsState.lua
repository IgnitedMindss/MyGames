SettingsState = Class{__includes = BaseState}

local currSelect = 1
local allSound = 6

function SettingsState:enter(params)
    self.highScores = params.highScores
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime
end

function SettingsState:update(dt)
    self.starSpawnTime = self.starSpawnTime + (dt*10)

    if self.starSpawnTime > 1 then
        table.insert(self.stars, NonInteractObj(11, 15))
        self.starSpawnTime = 0
    end

    for k, star in pairs(self.stars) do
        star:update(dt)
    end

    for k, star in pairs(self.stars) do
        if star.remove then
            table.remove(self.stars, k)
        end
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start', {
            highScores = self.highScores
        })
    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
        if MENU_SOUND then
            gSounds['select']:play()
            gSounds['select']:setVolume(0.5)
        end
        if currSelect == 1 then
            currSelect = 8
        else
            currSelect = currSelect - 1
        end
    elseif love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        if MENU_SOUND then
            gSounds['select']:play()
            gSounds['select']:setVolume(0.5)
        end
        if currSelect == 8 then
            currSelect = 1
        else
            currSelect = currSelect + 1
        end
    end

    if allSound == 6 then
        ALL_SOUND = true
    else
        ALL_SOUND = false
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if MENU_SOUND then
            gSounds['confirm']:stop()
            gSounds['confirm']:play()
            gSounds['confirm']:setVolume(0.5)
        end

        if currSelect == 1 then
            if ALL_SOUND then
                allSound = 0
                ALL_SOUND = false
                LASER_MISSLE_SOUND = false
                MET_DESTROY_SOUND = false
                EAR_CRITICAL_SOUND = false
                COLLECT_SOUND = false
                MENU_SOUND = false
                PLAYERSHIP_SOUND = false
            else
                allSound = 6
                ALL_SOUND = true
                LASER_MISSLE_SOUND = true
                MET_DESTROY_SOUND = true
                EAR_CRITICAL_SOUND = true
                COLLECT_SOUND = true
                MENU_SOUND = true
                PLAYERSHIP_SOUND = true
            end
        elseif currSelect == 2 then
            if LASER_MISSLE_SOUND then
                LASER_MISSLE_SOUND = false
                allSound = allSound - 1
            else
                LASER_MISSLE_SOUND = true
                allSound = allSound + 1
            end
        elseif currSelect == 3 then
            if MET_DESTROY_SOUND then
                MET_DESTROY_SOUND = false
                allSound = allSound - 1
            else
                MET_DESTROY_SOUND = true
                allSound = allSound + 1
            end
        elseif currSelect == 4 then
            if EAR_CRITICAL_SOUND  then
                EAR_CRITICAL_SOUND = false
                allSound = allSound - 1
            else
                EAR_CRITICAL_SOUND = true
                allSound = allSound + 1
            end
        elseif currSelect == 5 then
            if COLLECT_SOUND then
                COLLECT_SOUND = false
                allSound = allSound - 1
            else
                COLLECT_SOUND = true
                allSound = allSound + 1
            end
        elseif currSelect == 6 then
            if MENU_SOUND then
                MENU_SOUND = false
                allSound = allSound - 1
            else
                MENU_SOUND = true
                allSound = allSound + 1
            end
        elseif currSelect == 7 then
            if PLAYERSHIP_SOUND then
                PLAYERSHIP_SOUND = false
                allSound = allSound - 1
            else
                PLAYERSHIP_SOUND = true
                allSound = allSound + 1
            end
        elseif currSelect == 8 then
            if GUIDE then
                GUIDE = false
            else
                GUIDE = true
            end
        end
    end
end

function SettingsState:render()
    for k, star in pairs(self.stars) do
        star:render()
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('SETTINGS', 0, VIRTUAL_HEIGHT / 2 - 220, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('<- ESC', 5, 5)

    love.graphics.setFont(gFonts['midlarge'])
    love.graphics.printf('SOUNDS', 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH - 560, 'center')

    if currSelect == 1 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('ALL', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH - 630, 'center')
    if ALL_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 2 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('LASERS/MISSLES', 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH - 520, 'center')
    if LASER_MISSLE_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 3 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('METEOR DESTROY', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH - 515, 'center')
    if MET_DESTROY_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 4 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('EARTH CRITICAL', 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH - 530, 'center')
    if EAR_CRITICAL_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 - 10, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 5 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('COLLECTABLES', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH - 543, 'center')
    if COLLECT_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 6 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('MENU', 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH - 610, 'center')
    if MENU_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    if currSelect == 7 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('PLAYERSHIP', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH -563, 'center')
    if PLAYERSHIP_SOUND then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['midlarge'])
    love.graphics.printf('GUIDE', 0, VIRTUAL_HEIGHT / 2 + 120, VIRTUAL_WIDTH - 590, 'center')

    if currSelect == 8 then
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(1, 0, 1, 1)
    else
        love.graphics.setFont(gFonts['small'])
    end
    love.graphics.printf('GUIDE', 0, VIRTUAL_HEIGHT / 2 + 165, VIRTUAL_WIDTH -610, 'center')
    if GUIDE then
        love.graphics.printf('ON', 0, VIRTUAL_HEIGHT / 2 + 165, VIRTUAL_WIDTH - 100, 'center')
    else
        love.graphics.printf('OFF', 0, VIRTUAL_HEIGHT / 2 + 165, VIRTUAL_WIDTH - 100, 'center')
    end
    love.graphics.setColor(1, 1, 1, 1)
end