local class = require "code.modules.utils.middleclass"
local Math = require "code.modules.utils.math"
local Pack = class('Pack')

local _private = setmetatable({}, {__mode = "k"})

function Pack:initialize(id, units)
  _private[self] = {
    id = id,
    units = units
  }
end

function Pack:get_id()
  return _private[self].id
end

function Pack:get_random()
  local units = _private[self].units

  local weights = {}
  for i = 1, #units do
    table.insert(weights, i, units[i]:get_percent())
  end

  return units[Math.random_range_weight(weights)]
end

return Pack