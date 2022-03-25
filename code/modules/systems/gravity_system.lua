local class = require "code.modules.utils.middleclass"
local GravitySystem = class("GravitySystem")

local GRAVITY = 9.8
local AXIS_GRAVITY = vmath.vector3(0, -1, 0)

function GravitySystem:initialize(units)
  self.units = units
end

function GravitySystem:update(dt)
  for _, unit in ipairs(self.units) do
    local g = unit.mass * GRAVITY * AXIS_GRAVITY * dt
    unit.velocity = unit.velocity + g
    unit:set_position(unit.position + unit.velocity * dt)
  end
end

return GravitySystem
