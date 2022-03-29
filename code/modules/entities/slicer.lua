local class = require "code.modules.utils.middleclass"
local Slicer = class('Slicer')

function Slicer:initialize(args)
  self.view = args.view
  self.position = args.position or vmath.vector3()
  self.previous_position = args.previous_position or self.position
  self.radius = args.radius or 0
  self.min_speed_for_slice = args.min_speed_for_slice or 0
  self.active = args.active or false
  self.slicing = args.slicing or false
end

function Slicer:set_position(position)
  self.previous_position = self.position
  self.position = position
  go.set_position(position, self.view)
end

return Slicer