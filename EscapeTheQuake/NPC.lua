NPC = Class{}
-- 39 , 9 NPCSheet2
function NPC:init(playerX)
    self.npcWidth = CHARACTER_WIDTH
    self.npcHeight = CHARACTER_HEIGHT

    self.npcSheet = love.graphics.newImage('Assets/NPC/NPCSheet.png')
    self.npcQuads = GenerateQuads(self.npcSheet, 24, 34)

    self.trapSheet = love.graphics.newImage('Assets/NPC/NPCSheet2.png')
    self.trapQuads = GenerateQuads(self.trapSheet, 39, 9)
    self.type = math.random(5)

    if self.type == 1 then
        self.movingAnim = Animation {
            frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14},
            interval = 0.025
        }
    elseif self.type == 2 then
        self.movingAnim = Animation {
            frames = {15,16,17,18,19,20,21,22,23,24,25,26,27,28},
            interval = 0.025
        }
    elseif self.type == 3 then
        self.movingAnim = Animation {
            frames = {29,30,31,32,33,34,35,36,37,38,39,40,41,42},
            interval = 0.025
        }
    elseif self.type == 4 then
        self.movingAnim = Animation {
            frames = {43,44,45,46,47,48,49,50,51,52,53,54,55,56},
            interval = 0.025
        }
    elseif self.type == 5 then
        self.movingAnim = Animation {
            frames = {57,58,59,60,61,62,63,64,65,66,67,68,69,70},
            interval = 0.025
        }
    end

    self.currAnim = self.movingAnim
    self.direc = math.random(2)
    self.x = self.direc == 1 and playerX - 400 or playerX + 400
    self.y = ((8 - 1) * TILE_HEIGHT) - self.npcHeight
    if self.direc == 1 then
        self.direction = 'right'
    else
        self.direction = 'left'
    end
    self.isTraped = false
    self.countForTrap = true -- will count 1 time for adding totalNPCTraped
    self.wasHelped = false
    self.aliveTimer = 0
end

function NPC:update(dt)
    self.currAnim:update(dt)

    if self.direction == 'right' then
        if self.isTraped then
            self.npcWidth = 39
            self.npcHeight = 9
            self.y = ((8 - 1) * TILE_HEIGHT) - self.npcHeight
        else
            self.x = self.x + CHARACTER_MOVE_SPEED * dt
        end
    elseif self.direction == 'left' then
        if self.isTraped then
            self.npcWidth = 39
            self.npcHeight = 9
            self.y = ((8 - 1) * TILE_HEIGHT) - self.npcHeight
        else
            self.x = self.x - CHARACTER_MOVE_SPEED * dt
        end
    end

    self.aliveTimer = self.aliveTimer + dt
end

function NPC:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.npcWidth then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.npcHeight then
        return false
    end

    return true
end

function NPC:render()
    if self.isTraped then
        love.graphics.draw(signSheet, signQuads[5], math.floor(self.x), math.floor(self.y) - 13)

        love.graphics.draw(self.trapSheet, self.trapQuads[self.type],
        math.floor(self.x) + self.npcWidth / 2,
        math.floor(self.y) + self.npcHeight / 2,
        0,
        self.direction == 'right' and 1 or -1,
        1,
        self.npcWidth / 2,
        self.npcHeight/ 2)
    else
        if self.wasHelped then
            love.graphics.draw(signSheet, signQuads[6], math.floor(self.x), math.floor(self.y) - 13)
        else
            love.graphics.draw(signSheet, signQuads[7], math.floor(self.x), math.floor(self.y) - 13)
        end
        love.graphics.draw(self.npcSheet, self.npcQuads[self.currAnim:getCurrentFrame()],
        math.floor(self.x) + self.npcWidth / 2,
        math.floor(self.y) + self.npcHeight / 2,
        0,
        self.direction == 'right' and 1 or -1,
        1,
        self.npcWidth / 2,
        self.npcHeight/ 2)
    end
end