local class = require "code.modules.middleclass"
local Spawner = class('Spawner')

function Spawner:initialize(points)
  self.points = points
  pprint(self.points)
end

function Spawner:spawn(unit)
end

return Spawner