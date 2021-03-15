Tetromino = Class{}

local tetrominos = {['o'] = {},
['t'] = {{0, 1, 0}, {1, 1, 1}, {0, 0, 0}},
['l'] = {},
['s'] = {},
['i'] = {}}

local colors = {['o'] = {1, 0, 1}, ['t'] = {1, 0, 0},
['l'] = {0, 1, 0}, ['s'] = {0, 0, 1}, ['i'] = {0, 1, 1}}

local BOX_SIZE = 10

function Tetromino:init(type, x, y)
    self.type = type
    self.toggle = 0
    self.data = tetrominos[type]
    self.x = x
    self.y = y
end

function Tetromino:render()
    love.graphics.setColor(colors['t'])
    for i = 1, #self.data do
        for j = 1, #self.data do
            if self.data[i][j] == 1 then
                -- nastiest bug occured here because of mental association of
                -- x with i and y with j.
                love.graphics.rectangle("fill",
                self.x + (j - 1) * BOX_SIZE,
                self.y + (i - 1) * BOX_SIZE, BOX_SIZE, BOX_SIZE)
            end
        end
    end
end

function Tetromino:rotate()
    if self.toggle == 0 then
        flip(transpose(self.data))
        self.toggle = self.toggle + 1
    elseif self.toggle == 1 then
        transpose(self.data)
        self.toggle = 0
    end
end

function flip(arr)
    -- because we want to flip based on the columns not rows
    -- first we transose the matrix then flip it.
    arr_T = transpose(arr)
    for i = 1, #arr_T/2 do
        temp = arr_T[i]
        arr[i] = arr_T[#arr_T - i + 1]
        arr[#arr_T - i + 1] = temp
    end

    return transpose(arr_T)
end

function transpose(arr)
    for i = 1, #arr do
        for j = 1, #arr do
            if j > i then
                temp = arr[i][j]
                arr[i][j] = arr[j][i]
                arr[j][i] = temp
            end
        end
    end
    return arr
end

function printTable(arr)
    for i = 1, #arr do
        for j = 1, #arr do
            if arr[i][j] == 1 then
                io.write("1")
            elseif arr[i][j] == 0 then
                io.write("0")
            end
        end
        io.write("\n")
    end
end

