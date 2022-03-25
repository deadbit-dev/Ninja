local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local InputSystem = class("InputSystem")

function InputSystem:initialize()
  self.pressed = false
end

function InputSystem:on_input(action_id, action)
  if action_id == hash("touch") then
    local action_pos = vmath.vector3(action.x, action.y, 0)

    if action.pressed then
      self.pressed = true
      EventBus:emit(Events.ON_TOUCH_START, {pos = action_pos})
    elseif action.released then
      self.pressed = false
      EventBus:emit(Events.ON_TOUCH_END, {pos = action_pos})
    end

    if self.pressed then
      EventBus:emit(Events.ON_TOUCH_PROCESS, {pos = action_pos})
    end
  end
end

return InputSystem

