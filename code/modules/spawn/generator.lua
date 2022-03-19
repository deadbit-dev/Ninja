local class = require "code.modules.utils.middleclass"
local Generator = class('Generator')

function Generator:initialize(pack)
  self.pack = pack
end

function Generator:get_next_data() 
  local unit = self.pack:get_random_value()
  local data = {
    unit = msg.url(nil, self.pack.id, unit.id),
    modification = unit.modification
  }

  return data
end

return Generator
