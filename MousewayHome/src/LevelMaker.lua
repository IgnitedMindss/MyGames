LevelMaker = Class{}

function LevelMaker.generateLevel(width, height, curr_level)
    local level = curr_level
    local tiles = {}
    local objects = {}
    local entities = {}

    if level == 1 then

        for y = 1, height do
            table.insert(tiles, {})
            
            for x = 1, width do
                if y == 16 and (x > 1 and x < 8)then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif y == 14 and (x > 11 and x < 30) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y > 5 and y < 10) and (x > 18 and x < 23) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 17) and (x > 35 and x < 48) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y > 5 and y < 10) and (x == 18) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 4,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 20) and (x > 0 and x < 45) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif y == 13 and (x > 17 and x < 24) then
                    table.insert(tiles[y], Tile(x, y, SKY))
    
                    if( x >=19 and x <= 22) then
                        goto continue
                    end
    
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
    
                    ::continue::
                else
                    table.insert(tiles[y], Tile(x, y, SKY))
                end
            end
        end
        
        table.insert(objects,
            GameObject{
                texture = 'house',
                x = (42 - 1) * TILE_SIZE, y = (13 - 1) * TILE_SIZE,
                width = 36, height = 44,
                frame = 1,
                ishome = true
            }
        )
    
        table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (36 - 1) * TILE_SIZE, y = (16 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
    
        local map = TileMap(width, height)
        map.tiles = tiles
    
        return GameLevel(entities, objects, map)

    elseif level == 2 then

        for y = 1, height do
            table.insert(tiles, {})
            
            for x = 1, width do
                if y == 8 and (x > 1 and x < 7) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif y == 11 and (x > 8 and x < 12) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif y == 14 and (x > 13 and x < 20) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y > 10 and y < 16) and (x > 20 and x < 23) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 17) and (x > 25 and x < 30) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 14) and (x > 30 and x < 36) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 20) and (x > 15 and x < 22) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 20) and (x > 0 and x < 45) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                else
                    table.insert(tiles[y], Tile(x, y, SKY))
                end
            end
        end
    
        table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (6 - 1) * TILE_SIZE, y = (7 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
    
        table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (11 - 1) * TILE_SIZE, y = (10 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
    
        for x = 27, 29 do
            table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (16 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
        end
    
        for x = 21, 22 do
            table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (10 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
        end
    
        for x = 14, 16 do
            table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (13 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
        end
    
        table.insert(objects,
            GameObject{
                texture = 'house',
                x = (16 - 1) * TILE_SIZE, y = (16 - 1) * TILE_SIZE,
                width = 36, height = 44,
                frame = 1,
                ishome = true
            }
        )
    
        table.insert(objects,
            GameObject{
                texture = 'gems',
                x = (35 - 1) * TILE_SIZE, y = (13 - 1) * TILE_SIZE,
                width = 15, height = 11,
                frame = {1,2,3,4,5},
                consumable = true
            }
        )
    
        for x = 31, 33 do
            table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (13 - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
        end
    
        local map = TileMap(width, height)
        map.tiles = tiles
    
        return GameLevel(entities, objects, map)

    elseif level == 3 then

        for y = 1, height do
            table.insert(tiles, {})
            for x = 1, width do
                if y == 9 and (x > 5 and x < 12) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 12) and (x > 11 and x < 30) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 3) and (x == 13) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 17) and (x > 15 and x < 28) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 9) and (x > 31 and x < 35) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 6) and (x > 25 and x < 29) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y > 1 and y < 7) and (x == 26) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 0) and (x > 3 and x < 10) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 13) and (x > 22 and x < 30) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 2,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 3)  and (x == 12) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 4,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 2) and (x == 13) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = y == 2 and 1 or 2,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 4) and (x == 13) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = y == 2 and 1 or 2,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 8) and (x > 9 and x < 12) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y > 1 and y < 7) and (x == 25) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                    GameObject{
                        texture = 'spikes',
                        x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                        width = TILE_SIZE, height = TILE_SIZE,
                        frame = 4,
                        collidable = true,
                        solid = true,
                        deadly = true
                    }
                )
                elseif (y == 8) and (x == 34) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                    GameObject{
                        texture = 'spikes',
                        x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                        width = TILE_SIZE, height = TILE_SIZE,
                        frame = 1,
                        collidable = true,
                        solid = true,
                        deadly = true
                    }
                )
                elseif (y == 1) and (x > 3 and x < 10) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                    GameObject{
                        texture = 'spikes',
                        x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                        width = TILE_SIZE, height = TILE_SIZE,
                        frame = 2,
                        collidable = true,
                        solid = true,
                        deadly = true
                    }
                )
            elseif (y == 20) and (x > 0 and x < 45) then
                table.insert(tiles[y], Tile(x, y, SKY))
                table.insert(objects, 
                    GameObject{
                        texture = 'spikes',
                        x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                        width = TILE_SIZE, height = TILE_SIZE,
                        frame = 1,
                        collidable = true,
                        solid = true,
                        deadly = true
                    }
                )
                else
                    table.insert(tiles[y], Tile(x, y, SKY))
                end
            end
        end
    
        table.insert(objects,
            GameObject{
                texture = 'house',
                x = (16 - 1) * TILE_SIZE, y = (13 - 1) * TILE_SIZE,
                width = 36, height = 44,
                frame = 1,
                ishome = true
            }
        )
    
        table.insert(objects,
            GameObject{
                texture = 'gems',
                x = (28 - 1) * TILE_SIZE, y = (5 - 1) * TILE_SIZE,
                width = 15, height = 11,
                frame = {1,2,3,4,5},
                consumable = true
            }
        )
    
        local map = TileMap(width, height)
        map.tiles = tiles
    
        return GameLevel(entities, objects, map)

    elseif level == 4 then

         -- for y = 1, height do
    --     table.insert(tiles, {})
    -- end

    -- local lines = {{from = 2, to = 5, y = 7}, {from = 9, to = 36, y = 12}, {from = 11, to = 15, y = 17}, {from = 6, to = 6, y = 17}, {from = 39, to = 42, y = 16},}

    -- for _, line in pairs(lines) do -- draw lines
    --     if line.y then
    --             for x = line.from, line.to do
    --                     table.insert(tiles[line.y], Tile(x, line.y, math.random(1, 3)))
    --             end
    --     elseif line.x then
    --             for y = line.from, line.to do
    --                     table.insert(tiles[y], Tile(line.x, y, math.random(1, 3)))
    --             end
    --     end
    -- end

    -- for y = 1, height do
    --     -- table.insert(tiles, {})
    --         for x = 1, width do
    --             if tiles[y][x] then
    --             else
    --                 table.insert(tiles[y], Tile(x, y, SKY))
    --             end
    --         end
    -- end

        for y = 1, height do
            table.insert(tiles, {})
            for x = 1, width do
                if y == 12 and (x > 8 and x < 37) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif y == 17 and (x > 10 and x < 16) then
                        table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 17 and (x > 5 and x < 8)) then
                        table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif y == 16 and (x > 38 and x < 43) then
                        table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif y == 11 and (x > 12 and x < 15) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                    GameObject{
                        texture = 'spikes',
                        x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                        width = TILE_SIZE, height = TILE_SIZE,
                        frame = 1,
                        collidable = true,
                        solid = true,
                        deadly = true
                    }
                )
            elseif y == 11 and (x > 21 and x < 24) then
                table.insert(tiles[y], Tile(x, y, SKY))
                table.insert(objects, 
                GameObject{
                    texture = 'spikes',
                    x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                    width = TILE_SIZE, height = TILE_SIZE,
                    frame = 1,
                    collidable = true,
                    solid = true,
                    deadly = true
                }
            )
        elseif (y == 20) and (x > 0 and x < 45) then
            table.insert(tiles[y], Tile(x, y, SKY))
            table.insert(objects, 
                GameObject{
                    texture = 'spikes',
                    x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                    width = TILE_SIZE, height = TILE_SIZE,
                    frame = 1,
                    collidable = true,
                    solid = true,
                    deadly = true
                }
            )
            elseif y == 11 and (x > 30 and x < 33) then
                table.insert(tiles[y], Tile(x, y, SKY))
                table.insert(objects, 
                GameObject{
                    texture = 'spikes',
                    x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                    width = TILE_SIZE, height = TILE_SIZE,
                    frame = 1,
                    collidable = true,
                    solid = true,
                    deadly = true
                }
            )
            elseif y == 7 and (x > 1 and x < 6) then
                table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
            elseif y == 7 and (x == 6) then
                table.insert(tiles[y], Tile(x, y, SKY))
                table.insert(objects, 
                GameObject{
                    texture = 'spikes',
                    x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                    width = TILE_SIZE, height = TILE_SIZE,
                    frame = 3,
                    collidable = true,
                    solid = true,
                    deadly = true
                }
            )
            elseif y == 13 and (x > 8 and x < 16) then
                table.insert(tiles[y], Tile(x, y, SKY))
                table.insert(objects, 
                GameObject{
                    texture = 'spikes',
                    x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                    width = TILE_SIZE, height = TILE_SIZE,
                    frame = 2,
                    collidable = true,
                    solid = true,
                    deadly = true
                }
            )
            else
                table.insert(tiles[y], Tile(x, y, SKY))
                end
            end
        end

        table.insert(objects,
            GameObject{
                texture = 'house',
                x = (2 - 1) * TILE_SIZE, y = (3 - 1) * TILE_SIZE,
                width = 36, height = 44,
                frame = 1,
                ishome = true
            }
        )

        table.insert(objects,
            GameObject{
                texture = 'gems',
                x = (12 - 1) * TILE_SIZE, y = (16 - 1) * TILE_SIZE,
                width = 15, height = 11,
                frame = {1,2,3,4,5},
                consumable = true
            }
        )

        table.insert(objects,
            GameObject{
                texture = 'crank',
                x = (14 - 1) * TILE_SIZE, y = (15 - 1) * TILE_SIZE,
                width = 18, height = 22,
                frame = 1,
                switch = true
            }
        )

        local map = TileMap(width, height)
        map.tiles = tiles

        return GameLevel(entities, objects, map)

    elseif level == 5 then
        for y = 1, height do
            table.insert(tiles, {})
            
            for x = 1, width do
                if y == 6 and (x > 1 and x < 44)then
                    if(x > 5 and x < 10) or (x > 11 and x < 16) or (x > 17 and x < 22) or (x > 23 and x < 28) or (x > 29 and x < 34) or (x > 35 and x < 40) then
                        table.insert(tiles[y], Tile(x, y, SKY))
                    else
                        table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                    end
                elseif (y > 6 and y < 13) and (x == 2 or x == 43) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 13) and (x > 1 and x < 6) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 13) and (x > 40 and x < 44) then
                    table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                elseif (y == 12) and (x > 1 and x < 44) then
                    if(x > 2 and x < 7) or (x > 8 and x < 13) or (x > 14 and x < 19) or (x > 20 and x < 25) or (x > 26 and x < 31) or (x > 32 and x < 38) or (x > 39 and x < 43) then
                        table.insert(tiles[y], Tile(x, y, SKY))
                    else
                        table.insert(tiles[y], Tile(x, y, math.random(1, 3)))
                    end
                elseif (y == 5) and ((x > 15 and x < 18) or (x > 27 and x < 30)) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 20) and (x > 0 and x < 45) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 1,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                elseif (y == 1) and (x > 0 and x < 45) then
                    table.insert(tiles[y], Tile(x, y, SKY))
                    table.insert(objects, 
                        GameObject{
                            texture = 'spikes',
                            x = (x - 1) * TILE_SIZE, y = (y - 1) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            frame = 2 ,
                            collidable = true,
                            solid = true,
                            deadly = true
                        }
                    )
                else
                    table.insert(tiles[y], Tile(x, y, SKY))
                end
            end
        end

        table.insert(objects,
            GameObject{
                texture = 'house',
                x = (3 - 1) * TILE_SIZE, y = (9 - 1) * TILE_SIZE,
                width = 36, height = 44,
                frame = 1,
                ishome = true
            }
        )

        local map = TileMap(width, height)
        map.tiles = tiles

        return GameLevel(entities, objects, map)
    end

end
