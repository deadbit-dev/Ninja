local class = require "code.modules.utils.middleclass"
local GravitySystem = class("GravitySystem")

function GravitySystem:initialize(state, config)
  self.units = state.context.units
  self.gravity = config.GRAVITY
  self.gravity_axis = config.GRAVITY_AXIS
end

function GravitySystem:update(dt)
  for _, unit in ipairs(self.units) do
    unit.velocity = unit.velocity + unit.mass * self.gravity * self.gravity_axis * dt
    unit:set_position(unit.position + unit.velocity * dt)
  end
end

return GravitySystem
