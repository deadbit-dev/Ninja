local class = require "code.modules.utils.middleclass"
local View = require "code.modules.entities.view"
local Bomb = class('Bomb', View)

function Bomb:initialize(view, args)
  View.initialize(self, view, args)
  self.radius = args.radius or 0
  self.mass = args.mass or 0
  self.velocity = args.velocity or vmath.vector3()
  self.torque = args.torque or 0
  self.damage = args.damage or 0
end

return Bomb