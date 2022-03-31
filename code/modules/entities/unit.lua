local class = require "code.modules.utils.middleclass"
local View = require "code.modules.entities.view"
local Unit = class('Unit', View)

function Unit:initialize(view, args)
  View.initialize(self, view, args)
  self.parts = args.parts
  self.color = args.color
  self.radius = args.radius or 0
  self.mass = args.mass or 0
  self.velocity = args.velocity or vmath.vector3()
  self.torque = args.torque or 0
  self.score = args.score or 0
end

return Unit
