require 'src/Dependencies'

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest");
    love.graphics.setFont(gFonts["medium"])
    love.window.setTitle("Mouse's way Home");

    math.randomseed(os.time());

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = true, 
        resizable = true
    })

    gStateMachine = StateMachine{
        ['play'] = function () 
            return PlayState()
        end,
        ['start'] = function ()
            return StartState()
        end,
        ['enter-time'] = function ()
            return EnterBestTimeState()
        end,
        ['select-level-control'] = function ()
            return SelectLevelAndControlState()
        end
    }

    gStateMachine:change('start',{
        bestTimers = LoadBestTime()
    })

    -- intervals[1] -> dash recharge
    -- intervals[2] -> startstate 'press enter' flicker
    -- intervals[3] -> timer
    intervals = {1, 1, 1}
    counters = {0, 0, 0}

    for i = 1, #intervals do
        Timer.every(intervals[i], function()
            counters[i] = counters[i] + 1
        end)
    end

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end
