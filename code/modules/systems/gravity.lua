local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local GravitySystem = class("GravitySystem")

function GravitySystem:initialize(state)
  self.units = state.context.units
end

function GravitySystem:update(dt)
  for _, unit in ipairs(self.units) do
    unit.velocity = unit.velocity + unit.mass * config.GRAVITY * config.GRAVITY_AXIS * dt
    unit:set_position(unit.position + unit.velocity * dt)
  end
end

return GravitySystem
