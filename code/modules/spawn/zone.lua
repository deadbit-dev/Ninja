local class = require "code.modules.utils.middleclass"
local Point = require "code.modules.cammon.point"
local Zone = class('Zone')

function Zone:initialize(pointA, pointB)
  self.pointA = pointA
  self.pointB = pointB
end

function Zone:get_random_point()
  local pointA = self.pointA
  local pointB = self.pointB

  local weight = math.random()
  local pos = vmath.slerp(weight, pointA.pos, pointB.pos)
  local angle = vmath.lerp(weight, pointA.angle, pointB.angle)

  return Point(pos, angle)
end

return Zone