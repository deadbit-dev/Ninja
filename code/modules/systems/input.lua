local class = require "code.modules.utils.middleclass"
local InputSystem = class("InputSystem")

local TOUCH = hash("touch")

function InputSystem:initialize(eventbus)
  self.eventbus = eventbus
  self.pressed = false
end

function InputSystem:on_input(action_id, action)
  if action_id == TOUCH then
    local action_pos = vmath.vector3(action.x, action.y, 0)

    if action.pressed then
      self.pressed = true
      self.eventbus.arbiter:emit(self.eventbus.events.ON_TOUCH_START, {pos = action_pos})
    elseif action.released then
      self.pressed = false
      self.eventbus.arbiter:emit(self.eventbus.events.ON_TOUCH_END, {pos = action_pos})
    end

    if self.pressed then
      self.eventbus.arbiter:emit(self.eventbus.events.ON_TOUCH_PROCESS, {pos = action_pos})
    end
  end
end

return InputSystem

