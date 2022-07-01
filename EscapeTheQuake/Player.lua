Player = Class{}

function Player:init()
    self.playerSheet = love.graphics.newImage('Assets/Player/playersheet.png')
    self.playerQuads = GenerateQuads(self.playerSheet, 24, 34)

    self.movingAnim = Animation {
        frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14},
        interval = 0.025
    }
    self.idleAnim = Animation{
        frames = {15, 16},
        interval = 0.5
    }

    self.currAnim = self.idleAnim
    self.y = ((8 - 1) * TILE_HEIGHT) - CHARACTER_HEIGHT
    self.x = (VIRTUAL_WIDTH / 2) - (CHARACTER_WIDTH / 2)
    self.dy = 0
    self.direction = 'right'

    self.totalLeftTraped = 0
    self.arrowLDisTime = 0
    self.totalRightTraped = 0
    self.arrowRDisTime = 0
    self.totalTraped = 0

    self.width = CHARACTER_WIDTH
    self.height = CHARACTER_HEIGHT
end

function Player:update(dt)
    self.currAnim:update(dt)

    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.currAnim = self.movingAnim
        if self.x < 13000 then
            self.x = self.x + CHARACTER_MOVE_SPEED * dt
        end
        self.direction = 'right'
    elseif love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        -- left barrier for player
        if self.x + CHARACTER_WIDTH > 50 then
            self.currAnim = self.movingAnim
            self.x = self.x - CHARACTER_MOVE_SPEED * dt
            self.direction = 'left'
        end
    else
        self.currAnim = self.idleAnim
    end

    camScroll = self.x - (VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2)

    if self.totalLeftTraped > 0 then
        self.arrowLDisTime = self.arrowLDisTime + dt
        if self.arrowLDisTime > 3 then
            self.totalTraped = self.totalTraped + self.totalLeftTraped
            self.totalLeftTraped = 0
            self.arrowLDisTime = 0
        end
    end

    if self.totalRightTraped > 0 then
        self.arrowRDisTime = self.arrowRDisTime + dt
        if self.arrowRDisTime > 3 then
            self.totalTraped = self.totalTraped + self.totalRightTraped
            self.totalRightTraped = 0
            self.arrowRDisTime = 0
        end
    end
end

function Player:collides(target)
    if self.x > target.x + target.width or target.x > self.x + CHARACTER_WIDTH then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + CHARACTER_HEIGHT then
        return false
    end

    return true
end

function Player:render()
    love.graphics.draw(self.playerSheet, self.playerQuads[self.currAnim:getCurrentFrame()],
    math.floor(self.x) + CHARACTER_WIDTH / 2,
    math.floor(self.y) + CHARACTER_HEIGHT / 2,
    0,
    self.direction == 'right' and 1 or -1,
    1,
    CHARACTER_WIDTH / 2,
    CHARACTER_HEIGHT/ 2)
    if self.totalLeftTraped > 0 then
        if camScroll > 0 then
            love.graphics.draw(signSheet, signQuads[1], math.floor(self.x - math.random(128, 130)), VIRTUAL_HEIGHT / 2)
        else
            love.graphics.draw(signSheet, signQuads[1], math.floor(math.random(128, 130) - 22), VIRTUAL_HEIGHT / 2)
        end
    end

    if self.totalRightTraped > 0 then
        if camScroll > 0 then
            love.graphics.draw(signSheet, signQuads[2], math.floor(self.x + math.random(128, 130)), VIRTUAL_HEIGHT / 2)
        else
            love.graphics.draw(signSheet, signQuads[2], math.floor(VIRTUAL_WIDTH / 2 + math.random(128, 130) - 16), VIRTUAL_HEIGHT / 2)
        end
    end
end
