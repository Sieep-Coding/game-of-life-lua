local N = 5
local M = 5
local bools = {true,false}

local uni = {x = bools[math.random(1,2)], y = bools[math.random(1,2)]}
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