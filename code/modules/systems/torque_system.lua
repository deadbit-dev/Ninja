local class = require "code.modules.utils.middleclass"
local TorqueSystem = class("TorqueSystem")

function TorqueSystem:initialize(units)
  self.units = units
end

function TorqueSystem:update(dt)
  for _, unit in ipairs(self.units) do
    local rotation = unit.rotation
    rotation.z = rotation.z + unit.torque
    unit:set_rotation(rotation)
  end
end

return TorqueSystem
