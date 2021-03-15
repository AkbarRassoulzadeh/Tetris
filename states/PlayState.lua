PlayState = Class{__includes = BaseState}

function PlayState:init()
    tet = Tetromino('t', 60, 100)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('space') then
        tet:rotate()
    end
end

function PlayState:render()
    tet:render()
end
