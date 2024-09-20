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

--Get user input for density
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

local function getUserInputGeneration(generations)
  
    local generations 
   while true do
      io.write("Number of Generations (integer) ")
      generations = io.read()
      generations = tonumber(generations)
      if generations == nil then
          print("Please enter a number.")
      elseif generations < 0 then
          print("Please Enter a number greater than 0 ")
      else
          break
      end
  end
      io.write("Selected:", generations, "!\n")
      return generations
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
local function updateUniverse(universe, density)
    local newUni = newUniverse(density)
    for x=1, N do
        for y=1, M do
            local neighbors = countNeighbors(universe, x, y)
            local cell = universe[x][y]
            if cell == "X" then
                if neighbors < 2 then
                    newUni[x][y] = " " -- cell dies
                elseif neighbors > 3 then
                    newUni[x][y] = " "
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

local function printUniverse(universe)
    for x=1, N do
        for y=1, M do
            io.write(tostring(universe[x][y]) .. " ")
        end
        print()
    end
end

local function sleep(n)
    if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
  end
  

-- main loop
local density = getUserInputDensity()
uni = newUniverse(density)
local generations = getUserInputGeneration()
for gen = 1, generations do
    print("Generation:", gen)
    printUniverse(uni)
    uni = updateUniverse(uni, density)
    sleep(1)
end