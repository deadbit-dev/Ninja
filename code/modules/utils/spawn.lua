local class = require "code.modules.utils.middleclass"
local Spawn = {}

Spawn.Point = class('Point')

function Spawn.Point:initialize(
  position, 
  angle, 
  min_force, 
  max_force, 
  torque_force_min, 
  torque_force_max
)
  local DEFAULT_TORQUE_FORCE = {MIN = -3, MAX = 3} 

  self.pos = position
  self.angle = angle
  self.min_force = min_force
  self.max_force = max_force
  self.torque_force_min = torque_force_min or DEFAULT_TORQUE_FORCE.MIN
  self.torque_force_max = torque_force_min or DEFAULT_TORQUE_FORCE.MAX
end

Spawn.Zone = class('Zone')

function Spawn.Zone:initialize(pointA, pointB, weight)
  self.pointA = pointA
  self.pointB = pointB
  self.weight = weight
end

function Spawn.Zone:get_random_point()
  local pointA = self.pointA
  local pointB = self.pointB

  local weight = math.random()
  local pos = vmath.slerp(weight, pointA.pos, pointB.pos)
  local angle = vmath.lerp(weight, pointA.angle, pointB.angle)
  local min_force = vmath.lerp(weight, pointA.min_force, pointB.min_force)
  local max_force = vmath.lerp(weight, pointA.max_force, pointB.max_force)

  return Spawn.Point(pos, angle, min_force, max_force)
end

return Spawn