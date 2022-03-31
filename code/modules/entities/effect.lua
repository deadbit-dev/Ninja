local class = require "code.modules.utils.middleclass"
local View = require "code.modules.entities.view"
local Effect = class("Effect", View)

function Effect:initialize(view, args)
  View.initialize(self, view, args)
end

return Effect