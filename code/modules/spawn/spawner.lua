local class = require "code.modules.utils.middleclass"
local Spawner = class('Spawner')

function Spawner:initialize(gamefield, zones)
  self.gamefield = gamefield
  self.zones = zones
end

function Spawner:spawn(prefab)
  local point = self.zones:get_random_value().value:get_random_point()
  local pos = self.gamefield:screen_to_field(point.pos)

  local unit = factory.create(prefab, pos)
  go.set(unit, "euler.z", point.angle)

  return unit 
end

return Spawner