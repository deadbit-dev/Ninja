local class = require "code.modules.utils.middleclass"
local SpawnZone = class('SpawnZone')

function SpawnZone:initialize(first_point, second_point)
  self.first_point = first_point
  self.second_point = second_point
end

function SpawnZone:get_random_point()

end

return SpawnZone