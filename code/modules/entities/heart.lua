local class = require "code.modules.utils.middleclass"
local View = require "code.modules.entities.view"
local Heart = class('Heart', View)

function Heart:initialize(view, args)
  View.initialize(self, view, args)
  self.parts = args.parts
  self.radius = args.radius or 0
  self.mass = args.mass or 0
  self.velocity = args.velocity or vmath.vector3()
  self.torque = args.torque or 0
  self.healing = args.healing or 0
end

return Heart