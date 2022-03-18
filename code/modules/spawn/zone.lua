local class = require "code.modules.utils.middleclass"
local Point = require "code.modules.spawn.point"
local Zone = class('Zone')

local _private = setmetatable({}, {__mode = "k"})

function Zone:initialize(pointA, pointB, percent)
  _private[self] = {
    pointA = pointA,
    pointB = pointB,
    percent = percent
  }
end

function Zone:get_percent() 
  return _private[self].percent
end

function Zone:get_random_point()
  local pointA = _private[self].pointA
  local pointB = _private[self].pointB

  local posA = pointA:get_pos()
  local posB = pointB:get_pos()

  local v1 = vmath.vector3(posA.x, posA.y, pointA:get_angle())
  local v2 = vmath.vector3(posB.x, posB.y, pointB:get_angle())
  local v3 = vmath.slerp(math.random(), v1, v2)

  return Point(vmath.vector3(v3.x, v3.y, 0), v3.z)
end

return Zone