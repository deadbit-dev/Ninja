local class = require "code.modules.utils.middleclass"
local Slicer = class('Slicer')

function Slicer:initialize(args)
  self.id = args.id
  self.position = args.position or vmath.vector3()
  self.radius = args.radius or 0
  self.min_speed_for_slice = args.min_speed_for_slice or 0
  self.active = args.active or false
  self.slicing = args.slicing or false
end

return Slicer