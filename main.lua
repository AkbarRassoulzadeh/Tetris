push = require 'push'
Class = require 'class'

require 'Tetromino'

require 'StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/PlayState'

WINDOW_WIDTH = 400
WINDOW_HIGHT = 600

VIRTUAL_WIDTH = 150
VIRTUAL_HIGHT = 250

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Tetris')

    mediumFont = love.graphics.newFont('font.ttf', 14)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HIGHT, WINDOW_WIDTH, WINDOW_HIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('play')

    love.keyboard.keysPressed = {}
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

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end
