local class = require "code.modules.utils.middleclass"
local Point = class('Point')

function Point:initialize(position, angle)
  self.pos = position
  self.angle = angle
end

return Point
