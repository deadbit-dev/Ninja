local class = require "code.modules.utils.middleclass"
local Unit = class('unit')

local DEFAULT_RADIUS = 40
local DEFAULT_MASS = 50

function Unit:initialize(args)
  self.view = args.view
  self.position = args.position or vmath.vector3()
  self.rotation = args.rotation or vmath.vector3()
  self.scale = args.scale or vmath.vector3(1)
  self.radius = args.radius or DEFAULT_RADIUS
  self.mass = args.mass or DEFAULT_MASS
  self.velocity = args.velocity or vmath.vector3()
  self.torque = args.torque or 0
  self.sprites = args.sprites
  self.slicingable = args.slicingable or false

  go.set_position(self.position, self.view)
  go.set(self.view, "euler", self.rotation)
  go.set_scale(self.scale, self.view)
end

function Unit:set_position(position)
  self.position = position
  go.set_position(position, self.view)
end

function Unit:set_rotation(rotation)
  self.rotation = rotation
  go.set(self.view, "euler", rotation)
end

function Unit:set_scale(scale)
  self.scale = scale
  go.set_scale(scale, self.view)
end

function Unit:finalize()
  go.delete(self.view)
end

return Unit
