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
  local pos = _private[self].gamefield:screen_to_field(point:get_pos())
  local axis = vmath.vector3(0, 0, 1)
  local quat = vmath.quat_axis_angle(axis, point:get_angle())

  return factory.create(prefab, pos, quat)
end

return Spawner