local Bomb = {}
Bomb.__index = Bomb

function Bomb.new(x, y)
    local self = setmetatable({}, Bomb)
    self.bombObj = display.newCircle(x, y, 10)
    self.bombObj:setFillColor(1, 1, 1)
    return self
end

function Bomb:explode(onExplode)
    timer.performWithDelay(2000, function()
        if self.bombObj then
            self.bombObj:removeSelf()
            self.bombObj = nil
            onExplode()
        end
    end)
end

return Bomb
