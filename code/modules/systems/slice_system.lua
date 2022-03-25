local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local SliceSystem = class("SliceSystem")

function SliceSystem:initialize(slicer, units, gamefield)
  self.gamefield = gamefield
  self.slicer = slicer
  self.units = units
  self.previous_position = slicer.position

  EventBus:subscribe(Events.ON_TOUCH_START, self.touch_start, self)
  EventBus:subscribe(Events.ON_TOUCH_PROCESS, self.touch_process, self)
  EventBus:subscribe(Events.ON_TOUCH_END, self.touch_end, self)
end

function SliceSystem:update(dt)
  if not self.slicer.slicing then
    return
  end
  
  for index, unit in ipairs(self.units) do
    if self:inside_unit(unit) then
      unit:finalize()
      table.remove(self.units, index)
    end
  end
end

function SliceSystem:inside_unit(unit)
  return vmath.length(self.slicer.position - unit.position) < self.slicer.radius + unit.radius
end

function SliceSystem:touch_start(data)
  self.slicer.position = self.gamefield.camera.screen_to_world(self.gamefield.camera_id, data.pos)
  self.previous_position = self.slicer.position
  self.slicer.active = true
  self.slicer.slicing = false
end

function SliceSystem:touch_process(data)
  self.slicer.position = self.gamefield.camera.screen_to_world(self.gamefield.camera_id, data.pos)
  self:is_slice(self.slicer.position)
  self.previous_position = self.slicer.position
end

function SliceSystem:touch_end(data)
  self.slicer.active = false
end

function SliceSystem:is_slice(position)
  local speed = vmath.length(position - self.previous_position)

  if speed < self.slicer.min_speed_for_slice then
    self.slicer.slicing = false
    return
  end

  self.slicer.slicing = true
end

return SliceSystem
