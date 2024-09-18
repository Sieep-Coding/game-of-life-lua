local N = 50
local M = 50
local bools = {" ","X"}

local uni = {}

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
for x=1, N do
    uni[x] = {}
    for y=1, M do
        uni[x][y] = bools[math.random(1,2)]
    end
end

for x=1, N do
    for y=1, M do
        io.write(tostring(uni[x][y]) .. " ")
    end
    print()
end