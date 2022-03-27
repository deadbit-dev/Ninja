local class = require "code.modules.utils.middleclass"
local GravitySystem = class("GravitySystem")

local GRAVITY = 9.8
local AXIS_GRAVITY = vmath.vector3(0, -1, 0)

function GravitySystem:initialize(state)
  self.units = state.context.units
end

function GravitySystem:update(dt)
  for _, unit in ipairs(self.units) do
    unit.velocity = unit.velocity + unit.mass * GRAVITY * AXIS_GRAVITY * dt
    unit:set_position(unit.position + unit.velocity * dt)
  end
end

return GravitySystem
