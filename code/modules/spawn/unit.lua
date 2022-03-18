local class = require "code.modules.utils.middleclass"
local Unit = class("Unit")

local _private = setmetatable({}, {__mode = "k"})

function Unit:initialize(id, percent)
  _private[self] = {
    id = id,
    percent = percent
  }
end

function Unit:get_id()
  return _private[self].id
end

function Unit:get_percent()
  return _private[self].percent
end

return Unit