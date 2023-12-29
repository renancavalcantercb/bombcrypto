local physics = require("physics")

local Crate = {}
Crate.__index = Crate

local crate_type = {
    wood = {
        hp = 50,
        value = {
            min = 10,
            max = 50
        },
        color = {0.8, 0.4, 0}
    },
    metal = {
        hp = 100,
        value = {
            min = 51,
            max = 100
        },
        color = {0.5, 0.5, 0.5}
    }
}

function Crate.new(material)
    local self = setmetatable({}, Crate)
    local typeData = crate_type[material]

    if not typeData then
        error("Invalid material type: " .. tostring(material))
    end

    self.material = material
    self.hp = typeData.hp
    self.value = math.random(typeData.value.min, typeData.value.max)
    self.color = typeData.color
    self.crateObj = nil
    return self
end

function Crate:create(x, y, size)
    self.crateObj = display.newRect(x, y, size, size)
    self.crateObj:setFillColor(unpack(self.color))
    physics.addBody(self.crateObj, "static", { density=1.0, friction=0.3, bounce=0 })
end

function Crate:hit(damage)
    self.hp = self.hp - damage
    if self.hp <= 0 then
        self:destroy()
        return self.value
    end
    return 0
end

function Crate:destroy()
    if self.crateObj then
        self.crateObj:removeSelf()
        self.crateObj = nil
    end
end

return Crate
