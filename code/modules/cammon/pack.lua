local class = require "code.modules.utils.middleclass"
local Math = require "code.modules.utils.math"
local Pack = class('Pack')

function Pack:initialize(id, elements)
  self.id = id
  self.elements = elements
end

function Pack:get_random_value()
  local elements = self.elements

  local weights = {}
  for i = 1, #elements do
    table.insert(weights, i, elements[i].weight or 0)
  end
  
  return elements[Math.random_range_weight(weights)]
end

return Pack