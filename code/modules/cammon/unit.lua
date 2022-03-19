local class = require "code.modules.utils.middleclass"
local Unit = class("Unit")

function Unit:initialize(id, default, modification)
  self.id = id
  self.modification = default

  if modification then
    for key, value in pairs(modification) do
      self.modification[key] = value
    end
  end
end

return Unit