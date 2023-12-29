local physics = require("physics")
local Bomb = require("bomb")

local Player = {}
Player.__index = Player

local player_type = {
    ["Common"] = {
        color = {0.8, 0.4, 0}
    },
    ["Rare"] = {
        color = {0.5, 0.5, 0.5}
    },
    ["Super Rare"] = {
        color = {0.5, 0, 0.5}
    }
}


function Player.new(type, power, speed, stamina, bomb_num, bomb_range)
    local self = setmetatable({}, Player)
    self.type = type
    self.power = power
    self.speed = speed
    self.stamina = stamina
    self.bomb_num = bomb_num
    self.bomb_range = bomb_range
    self.playerObj = display.newCircle(0, 15, 15, 15)
    self.playerObj:setFillColor(unpack(player_type[type].color))
    physics.addBody(self.playerObj, "dynamic", { density=10.0, friction=0.5, bounce=0, isFixedRotation=true })
    return self
end

function Player:moveCharacter(event)
    if event.phase == "began" or event.phase == "moved" then
        local xDirection = 0
        local yDirection = 0

        if event.x < display.contentWidth / 2 then
            xDirection = -1
        elseif event.x >= display.contentWidth / 2 then
            xDirection = 1
        end

        if event.y < display.contentHeight / 2 then
            yDirection = -1
        elseif event.y >= display.contentHeight / 2 then
            yDirection = 1
        end

        self.playerObj:setLinearVelocity(xDirection * (self.speed * 100), yDirection * (self.speed * 100))
    elseif event.phase == "ended" or event.phase == "cancelled" then
        self.playerObj:setLinearVelocity(0, 0)
    end
end

function Player:placeBomb()
    local x, y = self.playerObj.x, self.playerObj.y
    local bomb = Bomb.new(x, y)
    bomb:explode(function()
        local explosion = display.newRect(x, y, 25, 25)
        explosion:setFillColor(1, 0, 0)
        timer.performWithDelay(100, function()
            explosion:removeSelf()
            explosion = nil
        end)
    end)
end


return Player
