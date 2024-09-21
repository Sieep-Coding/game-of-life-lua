local N = 50 
local M = 50
local uni = {}

-- directional array that allows pixel X to
-- check for another X nearby.
local dir = {
    {-1, -1}, {0, -1}, {1, -1},
    {1, 0}, {1, 1},
    {0, 1}, {-1, 1}, {-1, 0},
}

-- Get user input for density
local function getUserInputDensity()
    local density 
    while true do
        io.write("Universe Density (Float between 0 and 1): ")
        density = io.read()
        density = tonumber(density)
        if density == nil then
            print("Please enter a valid number between 0 and 1.")
        elseif density < 0 or density > 1 then
            print("Please enter a number between 0 and 1.")
        else
            break
        end
    end
    io.write("Selected density: ", density, "!\n")
    return density
end

-- Get user input for the number of generations
local function getUserInputGeneration()
    local generations 
    while true do
        io.write("Number of Generations (positive integer): ")
        generations = io.read()
        generations = tonumber(generations)
        if generations == nil then
            print("Please enter a valid number.")
        elseif generations <= 0 then
            print("Please enter a number greater than 0.")
        else
            break
        end
    end
    io.write("Selected generations: ", generations, "!\n")
    return generations
end

-- Creates a new universe with a given density
local function newUniverse(density)
    local newUni = {}
    for x = 1, N do
        newUni[x] = {}
        for y = 1, M do
            if math.random() < density then
                newUni[x][y] = "X"
            else
                newUni[x][y] = " "
            end
        end
    end
    return newUni
end

-- Counts the neighbors of a cell at position (x, y)
local function countNeighbors(universe, x, y)
    local count = 0
    for i = 1, #dir do
        local row = (x + dir[i][1] - 1) % N + 1
        local col = (y + dir[i][2] - 1) % M + 1
        if universe[row][col] == "X" then
            count = count + 1
        end
    end
    return count
end

-- Updates the universe based on the rules of the Game of Life
local function updateUniverse(universe)
    local newUni = {}
    for x = 1, N do
        newUni[x] = {}
        for y = 1, M do
            local neighbors = countNeighbors(universe, x, y)
            local cell = universe[x][y]
            if cell == "X" then
                if neighbors < 2 or neighbors > 3 then
                    newUni[x][y] = " " -- cell dies
                else
                    newUni[x][y] = "X" -- cell lives
                end
            else
                if neighbors == 3 then
                    newUni[x][y] = "X" -- new cell is born
                else
                    newUni[x][y] = " "
                end
            end
        end
    end
    return newUni
end

-- Prints the universe in the terminal
local function printUniverse(universe)
    for x = 1, N do
        for y = 1, M do
            io.write(universe[x][y] .. " ")
        end
        print()
    end
end

-- Main loop
local density = getUserInputDensity()
uni = newUniverse(density)
local generations = getUserInputGeneration()

for gen = 1, generations do
    print("Generation:", gen)
    printUniverse(uni)
    uni = updateUniverse(uni)
end
