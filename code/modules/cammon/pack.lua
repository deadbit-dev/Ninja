local class = require "code.modules.utils.middleclass"
local Math = require "code.modules.utils.math"
local Pack = class('Pack')

function Pack:initialize(id, units)
  self.id = id
  self.units = units
end

function Pack:get_random_value()
  local units = self.units

  local weights = {}
  for i = 1, #units do
    table.insert(weights, i, units[i].percent)
  end

  return units[Math.random_range_weight(weights)]
end

return Pack