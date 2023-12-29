local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

local Scene = require("scene")
local Blocks = require("blocks")
local Player = require("player")
local Crate =  require("crate")

local scene = Scene.new()
scene:setup()

local blocks = Blocks.new()
blocks:generateMapBlocks()

local player = Player.new("Common", 8, 3, 5, 3, 3)

local function moveCharacter(event)
    player:moveCharacter(event)
end

Runtime:addEventListener("touch", moveCharacter)

local function getRandomFreePositions(numPositions)
    local positions = {}
    return positions
end

local function createRandomCrates(numCrates)
    local freePositions = getRandomFreePositions(numCrates)
    local crates = {}
    for i, pos in ipairs(freePositions) do
        local material = (i % 2 == 0) and "wood" or "metal"
        local hp = math.random(50, 100)
        local value = math.random(10, 50) 
        local crate = Crate.new(material, hp, value)
        crate:create(pos.x, pos.y, 50)
        table.insert(crates, crate)
    end
    return crates
end

local crates = createRandomCrates(10)

local bombIcon = display.newImage("bomb.png")
bombIcon:scale(0.05, 0.05)
bombIcon.x = display.contentWidth
bombIcon.y = display.contentHeight


bombIcon:addEventListener("tap", function()
    player:placeBomb()
end)

-- when press spacebar, place bomb
Runtime:addEventListener("key", function(event)
    if event.keyName == "space" and event.phase == "down" then
        player:placeBomb()
    end
end)
