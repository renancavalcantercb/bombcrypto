local physics = require("physics")

local Scene = {}
Scene.__index = Scene

function Scene.new()
    local self = setmetatable({}, Scene)
    return self
end

function Scene:setup()
    self:setupGround()
    self:setupCeiling()
    self:setupWalls()
end

function Scene:setupGround()
    local ground = display.newRect(display.contentCenterX, display.contentHeight, display.contentWidth, 0)
    ground:setFillColor(0, 1, 0)
    physics.addBody(ground, "static", { density=10.0, friction=0.5, bounce=0 })
end

function Scene:setupCeiling()
    local ceiling = display.newRect(display.contentCenterX, 0, display.contentWidth, 0)
    ceiling:setFillColor(0, 0, 0)
    physics.addBody(ceiling, "static", { density=10.0, friction=0.5, bounce=0 })
end

function Scene:setupWalls()
    self:createBlock(0, display.contentCenterY, 25, display.contentHeight)
    self:createBlock(display.contentWidth, display.contentCenterY, 25, display.contentHeight)
end

function Scene:createBlock(x, y, width, height)
    local block = display.newRect(x, y, width, height)
    block:setFillColor(0.6, 0.4, 0)
    physics.addBody(block, "static", { density=10.0, friction=0.5, bounce=0 })
    return block
end

return Scene
