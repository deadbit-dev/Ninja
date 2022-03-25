local class = require "code.modules.utils.middleclass"
local Unit = class('unit')

local DEFAULT_RADIUS = 40
local DEFAULT_MASS = 20

function Unit:initialize(args)
  self.id = args.id
  self.position = args.position or vmath.vector3()
  self.rotation = args.rotation or vmath.vector3()
  self.scale = args.scale or vmath.vector3(1)
  self.velocity = args.velocity or vmath.vector3()
  self.mass = args.mass or DEFAULT_MASS
  self.radius = args.radius or DEFAULT_RADIUS
  self.torque = args.torque or 0
end

function Unit:instantiate()
  self.id = factory.create(self.id)
  go.set_position(self.position, self.id)
  go.set_scale(self.scale, self.id)
  go.set(self.id, "euler", self.rotation)
end

function Unit:set_position(position)
  self.position = position
  go.set_position(position, self.id)
end

function Unit:set_rotation(rotation)
  self.rotation = rotation
  go.set(self.id, "euler", rotation)
end

function Unit:set_scale(scale)
  self.scale = scale
  go.set_scale(scale, self.id)
end

function Unit:finalize()
  go.delete(self.id)
end

return Unit
