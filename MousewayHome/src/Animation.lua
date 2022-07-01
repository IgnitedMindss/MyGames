Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.onetime = def.onetime
    self.timer = 0
    self.currentFrame = 1
    self.pause_anim = false
end

function Animation:update(dt)
    if not self.pause_anim then
        if #self.frames > 1 then
            self.timer = self.timer + dt
    
            if self.timer > self.interval then
                self.timer = self.timer % self.interval
    
                self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
            end
        end
    end

    if self.onetime then
        if self.currentFrame == #self.frames then
            self.pause_anim = true
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end