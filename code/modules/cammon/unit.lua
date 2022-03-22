local class = require "code.modules.utils.middleclass"
local Unit = class('Unit')

function Unit:initialize(view, param)
  self.view = view

  self.position = param.position or vmath.vector3()
  go.set_position(self.position, self.view)
  
  self.rotation = param.rotation or vmath.vector3()
  go.set(self.view, "euler", self.rotation)

  self.scale = param.scale or vmath.vector3(1)
  go.set_scale(self.scale, self.view)

  self.velocity = param.velocity or vmath.vector3()
  self.torque = param.torque or vmath.vector3()
  self.mass = param.mass or 0
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

return Unit