local class = require "code.modules.utils.middleclass"
local Spawner = class('Spawner')

local _private = setmetatable({}, {__mode = "k"})

function Spawner:initialize(gamefield, zones)
  _private[self] = {
    gamefield = gamefield,
    zones = zones
  }
end

function Spawner:spawn(prefab)
  local point = _private[self].zones:get_random():get_random_point()
  local pos = point:get_pos()

  pos = _private[self].gamefield:screen_to_field(pos)

  return factory.create(prefab, pos)
end

return Spawner