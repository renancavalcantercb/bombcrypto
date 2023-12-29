local physics = require("physics")
local Crate = require("crate")

local Blocks = {}
Blocks.__index = Blocks

function Blocks.new()
    local self = setmetatable({}, Blocks)
    self.blocks = {}
    return self
end

function Blocks:createBlock(x, y, width, height)
    local block = display.newRect(x, y, width, height)
    block:setFillColor(0.6, 0.4, 0)
    physics.addBody(block, "static", { density=10.0, friction=0.5, bounce=0 })
    table.insert(self.blocks, block)
end

function Blocks:generateMapBlocks()
    local blockWidth = 25
    local blockHeight = 25
    local rows = 4
    local columns = 6
    local blockSpacing = 70
    local startX = 65
    local startY = 50

    for row = 1, rows do
        for col = 1, columns do
            local x = startX + (col - 1) * blockSpacing
            local y = startY + (row - 1) * blockSpacing
            self:createBlock(x, y, blockWidth, blockHeight)
            local chance = math.random(1, 10)
            local crate = Crate.new("wood", 50, 50)
            local crateX = x
            local crateY = y
            if math.random(1, 5) == 1 then
                crateX = crateX + 25 + blockWidth / 2
                crate:create(crateX, crateY, 25)
            end
        end
    end
end

return Blocks
