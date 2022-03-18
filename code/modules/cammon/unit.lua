local class = require "code.modules.utils.middleclass"
local Unit = class("Unit")

function Unit:initialize(config, param)
  for key, value in pairs(config) do
    self[key] = param[key] or value
  end
end

return Unit