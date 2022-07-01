ControlsState = Class{__includes = BaseState}

function ControlsState:enter(params)
    self.bot = love.graphics.newArrayImage(gTextures['bots'])
    self.powerups = love.graphics.newArrayImage(gTextures['powerups'])
    self.lasers = love.graphics.newArrayImage(gTextures['lasers'])
    self.highScores = params.highScores
    self.stars = params.stars
    self.starSpawnTime = params.starsSpawnTime
end

function ControlsState:update(dt)

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
end

function ControlsState:render()
    for k, star in pairs(self.stars) do
        star:render()
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('CONTROLS', 0, VIRTUAL_HEIGHT - 440, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.print('<- ESC', 5, 5)

    love.graphics.setFont(gFonts['verySmall'])
    love.graphics.print('< SPACE >    =  SHOOT', 70, 100)

    love.graphics.print('< 1 >          =  PRIMARY WEAPON', 70, 130)
    love.graphics.drawLayer(self.lasers, 1 ,  140, 135, 2)

    love.graphics.print('< 2 >          =  SECOND WEAPON', 70, 160)
    love.graphics.drawLayer(self.lasers, 2 ,  140, 165, 2)

    love.graphics.print('< 3 >          =  THIRD WEAPON', 70, 190)
    love.graphics.drawLayer(self.lasers, 3 ,  140, 195, 2)

    love.graphics.print('< 4 >          =  FOURTH WEAPON', 70, 220)
    love.graphics.drawLayer(self.lasers, 4 ,  140, 225, 2)

    love.graphics.print('< <- or A >  =  MOVE LEFT', 70, 250)
    love.graphics.print('< -> or D >  =  MOVE RIGHT', 70, 280)

    love.graphics.print('< G >         =  HELPER BOT', 70, 310)
    love.graphics.drawLayer(self.bot, 1, 110, 300)

    love.graphics.setFont(gFonts['tiny'])
    love.graphics.print('HELPER BOT ASSISTS YOU IN DESTROYING', 70, 350)
    love.graphics.print('METEORS. IT WILL FIRE THE SELECTED', 70, 365)
    love.graphics.print('WEAPON YOUR PLAYERSHIP IS USING.', 70, 380)

    love.graphics.setFont(gFonts['verySmall'])
    love.graphics.print('< H >         =  + HEALTH', 400, 98)
    love.graphics.drawLayer(self.powerups, 2, 440, 80)

    love.graphics.setFont(gFonts['tiny'])
    love.graphics.print('INCREASES +3 THE HEALTH OF EARTH UPTO 10 SEC.', 400, 130)

    love.graphics.setFont(gFonts['verySmall'])
    love.graphics.print('< J >         =  SHIELD', 400, 165)
    love.graphics.drawLayer(self.powerups, 4, 440, 147)

    love.graphics.setFont(gFonts['tiny'])
    love.graphics.print('SHIELDS THE EARTH LAYER FOR 10 SEC. METEOR/S WENT PAST BY', 400, 197)
    love.graphics.print('THE PLAYERSHIP WILL NOT AFFECT THE EARTHS HEALTH.', 400, 212)

    love.graphics.setFont(gFonts['verySmall'])
    love.graphics.print('< k >         =  + FIREPOWER', 400, 247)
    love.graphics.drawLayer(self.powerups, 6, 440, 229)

    love.graphics.setFont(gFonts['tiny'])
    love.graphics.print('FIRES 3 MISSLES/LASERS INSTEAD OF 2 AT A TIME (FOR 10 SEC).', 400, 279)

    love.graphics.setFont(gFonts['verySmall'])
    love.graphics.print('< L >         =  + SPEED', 400, 314)
    love.graphics.drawLayer(self.powerups, 8, 440, 296)

    love.graphics.setFont(gFonts['tiny'])
    love.graphics.print('INCREASES THE SPEED OF PLAYERSHIP FOR 10 SEC.', 400, 346)
end