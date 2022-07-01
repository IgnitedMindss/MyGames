
-- size of our actual window
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 490
VIRTUAL_HEIGHT = 220

-- global standard tile size
TILE_SIZE = 11

-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

-- camera scrolling speed
CAMERA_SPEED = 100

-- speed of scrolling background
BACKGROUND_SCROLL_SPEED = 10

SKY = 4
GROUND1 = 1
GROUND2 = 2
GROUND3 = 3

-- player walking speed
PLAYER_WALK_SPEED = 90

-- player jumping velocity
PLAYER_JUMP_VELOCITY = -100

-- player DASH distance
PLAYER_DASH = 50

EAGLE_MOVING_SPEED = 60
FROG_MOVING_SPEED = 60


COLLIDABLE_TILES = {
    GROUND1, GROUND2, GROUND3
}