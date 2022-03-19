local class = require "code.modules.utils.middleclass"
local Math = require "code.modules.utils.math"
local Pack = class('Pack')

function Pack:initialize(id, values)
  self.id = id
  self.values = values
end

function Pack:get_random_value()
  local values = self.values

  local weights = {}
  for i = 1, #values do
    table.insert(weights, i, values[i].weight or 0)
  end

  return values[Math.random_range_weight(weights)].value
end

return Pack