local class = require "code.modules.utils.middleclass"
local GameFieldSystem = class("GameFieldSystem")

function GameFieldSystem:initialize(world)
  self.units = world.state.context.units
  self.camera = world.entities.camera
end

function GameFieldSystem:update(dt)
  local bounds = self.camera.behaviour.screen_to_world_bounds(self.camera.id)

  for index, unit in ipairs(self.units) do
    if self:unit_exit_bounds(unit, bounds) then
      unit:finalize()
      table.remove(self.units, index)
    end
  end
end

-- LEFT-x, TOP-y, RIGHT-z, BOTTOM-w
function GameFieldSystem:unit_exit_bounds(unit, bounds)
  return unit.position.x + unit.radius < bounds.x or 
         unit.position.y - unit.radius > bounds.y or 
         unit.position.x - unit.radius > bounds.z or 
         unit.position.y + unit.radius < bounds.w
end

return GameFieldSystem
