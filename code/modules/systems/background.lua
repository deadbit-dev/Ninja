local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local BackgroundSystem = class("BackgroundSystem")

function BackgroundSystem:initialize(world)
  self.background = world.entities.background

  window.set_listener(self.window_callback)
end

function BackgroundSystem:window_callback(event, data)
  if event == window.WINDOW_EVENT_RESIZED then
    print("Window resized: ", data.width / config.WIDTH, data.height / config.HEIGHT)

    local width = data.width / config.WIDTH
    local height = data.height / config.HEIGHT
    -- local scale = vmath.vector3(1)

    -- if width < 1 and height > 1 then
      -- scale = vmath.vector3(height, height, 1)
    -- end

    -- go.set_scale(scale, self.background)
  end
end

return BackgroundSystem