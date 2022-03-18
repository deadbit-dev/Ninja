local class = require "code.modules.utils.middleclass"
local Point = class('Point')

local _private = setmetatable({}, {__mode = "k"})

function Point:initialize(position, angle)
  _private[self] = {
    pos = position,
    angle = angle
  }
end

function Point:get_pos()
  return _private[self].pos
end

function Point:get_angle()
  return _private[self].angle
end

return Point
