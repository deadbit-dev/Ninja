local class = require "code.modules.utils.middleclass"
local lang = require "code.modules.utils.lang"
local Generator = class('Generator')

function Generator:initialize(pack)
  self.pack = pack
end

function Generator:get_next_data() 
  local unit = self.pack:get_random_value()
  
  local data = {
    url = msg.url(nil, self.pack.id, unit.id),
    meta = unit.value
  }

  return data
end

return Generator
