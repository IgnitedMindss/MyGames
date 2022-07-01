
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

--[[
    Divides quads we've generated via slicing our tile sheet into separate tile sets.
]]
function GenerateTileSets(quads, setsX, setsY, sizeX, sizeY)
    local tilesets = {}
    local tableCounter = 0
    local sheetWidth = setsX * sizeX
    local sheetHeight = setsY * sizeY

    -- for each tile set on the X and Y
    for tilesetY = 1, setsY do
        for tilesetX = 1, setsX do
            
            -- tileset table
            table.insert(tilesets, {})
            tableCounter = tableCounter + 1

            for y = sizeY * (tilesetY - 1) + 1, sizeY * (tilesetY - 1) + 1 + sizeY do
                for x = sizeX * (tilesetX - 1) + 1, sizeX * (tilesetX - 1) + 1 + sizeX do
                    table.insert(tilesets[tableCounter], quads[sheetWidth * (y - 1) + x])
                end
            end
        end
    end

    return tilesets
end


function LoadBestTime()
    love.filesystem.setIdentity('MouseswayHome')

    if not love.filesystem.getInfo('MouseswayHome.lst') then
        local times = ''

        for i = 1, 5 do
            times = times .. '---\n' -- name of the player
            times = times .. '100\n' -- total mins
            times = times .. '100\n' -- total secs
        end

        love.filesystem.write('MouseswayHome.lst', times)
    end

    local line_wrt_each_time = 1
    local counter = 1

    local timers = {}

    for i = 1, 10 do
        timers[i] = {
            name = nil,
            min = nil,
            sec = nil
        }
    end

    for line in love.filesystem.lines('MouseswayHome.lst') do
        if line_wrt_each_time == 1 then
            timers[counter].name = line .. ''
            line_wrt_each_time = line_wrt_each_time + 1
        elseif line_wrt_each_time == 2 then
            timers[counter].min = tonumber(line)
            line_wrt_each_time = line_wrt_each_time + 1
        elseif line_wrt_each_time == 3 then
            timers[counter].sec = tonumber(line)
            line_wrt_each_time = 1
            counter = counter + 1
        end
    end

    return timers
end
