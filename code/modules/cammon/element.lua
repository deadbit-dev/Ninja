local class = require "code.modules.utils.middleclass"
local Element = class("Element")

function Element:initialize(id, value, weight)
  self.id = id
  self.value = value
  self.weight = weight
end

return Element