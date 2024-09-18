local N = 50 -- turn into to io.input for main loop
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
local function getUserInput(input)
  input = io.read()
  return input
end

--Get Terminal size
local function(width,height)
  local width = io.popen("")
  return width,height
end

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

--Uses dir to count nearby neighbors
-- local function countNeighbors(universe, x, y)
--     local count = 0
--     for dir =2,20 do
--         local row = (y + ) 
--     end
--     return count
-- end

--apply random boolean
for x=1, N do
    uni[x] = {}
    for y=1, M do
        uni[x][y] = bools[math.random(1,2)]
    end
end

--print random boolean
for x=1, N do
    for y=1, M do
        io.write(tostring(uni[x][y]) .. " ")
    end
    print()
end
