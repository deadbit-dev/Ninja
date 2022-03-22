local class = require "code.modules.utils.middleclass"
local Unit = require "code.modules.cammon.unit"
local Spawner = class('Spawner')

function Spawner:initialize(gamefield, zones)
  self.gamefield = gamefield
  self.zones = zones
end

function Spawner:spawn(data)
  local zone = self.zones:get_random_value()
  local point = zone.value:get_random_point()
  local pos = self.gamefield:screen_to_field(point.pos)
  local view = factory.create(data.url)
  local angle = point.angle

  data.meta.position = pos
  data.meta.velocity = vmath.vector3(math.cos(angle), math.sin(angle), 0) * data.meta.force

  return Unit(view, data.meta)
end

return Spawner