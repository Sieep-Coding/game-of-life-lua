local N = 50 
local M = 50
local bools = {" ","X"}

local uni = {}

-- directional array that allows pixel X to
-- check for another X nearby.
local dir = {
    {-1, -1}, {0, -1}, {1, -1},
    {1, 0}, {1, 1},
    {0, 1}, {-1, 1}, {-1, 0},
}

--Get user input
local function getUserInputDensity(density)
  
  local density 
 while true do
    io.write("Universe Density (Float) ")
    density = io.read()
    density = tonumber(density)
    if density == nil then
        print("Please enter a number between 0 and 1.")
    elseif density < 0 or density > 1 then
        print("Please Enter a number between 0 and 1 ")
    else
        break
    end
end
    io.write("Selected:", density, "!\n")
    return density
end

--Get Terminal size
-- local function(height)
--   local width = io.popen("")
--   return width,height
-- end

--Creates a new universe.
local function newUniverse(density) 
    local newUni = {}
    for x=1, N do
        newUni[x] = {}
            for y=1, M do
            if math.random() < density then
                newUni[x][y] = "X"
            else
                newUni[x][y] = " "
            end
        end
    end
    return newUni
end

--Uses dir to check for nearby neighbors
local function countNeighbors(universe, x, y)
    local count = 0
    for i =1, 8 do
        local row = (x + dir[i][1] - 1) % N + 1
        local col = (y + dir[i][2] - 1) % M + 1
        if universe[row][col] == "X" then
            count = count + 1
        end
    end
    return count
end

-- update Universe based on the rules of the Game of Life
local function updateUniverse(universe, survivalRule, birthRule)
    local newUni = newUniverse()
    for x=1, N do
        for y=1, M do
            local neighbors = countNeighbors(universe, x, y)
            local cell = universe[x][y]
            if cell == "X" then
                if neighbors < 2 and neighbors > 3 then
                    newUni[x][y] = " " -- cell dies
                else 
                    newUni[x][y] = "X"
                end
            else
                if neighbors == 3 then
                    newUni[x][y] = "X"
                end
            end
        end
    end
    return newUni
end

  
  --apply random boolean
for x=1, N do
    uni[x] = {}
    for y=1, M do
        uni[x][y] = newUniverse(getUserInputDensity())
    end
end

--print random boolean
for x=1, N do
    for y=1, M do
        io.write(tostring(uni[x][y]) .. " ")
    end
    print()
end