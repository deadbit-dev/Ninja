local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local Unit = require "code.modules.entities.unit"
local SliceSystem = class("SliceSystem")

function SliceSystem:initialize(state, eventbus)
  self.eventbus = eventbus
  self.camera = state.context.camera
  self.spawner = state.context.spawner
  self.slicer = state.context.slicer
  self.units = state.context.units

  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_TOUCH_START, self.touch_start, self)
  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_TOUCH_PROCESS, self.touch_process, self)
  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_TOUCH_END, self.touch_end, self)
end

function SliceSystem:update(dt)

  if not self.slicer.slicing then
    return
  end

  for index, unit in ipairs(self.units) do
    if self:inside_unit(unit) and not unit.slicingable then
      local position = unit.position
      local rotation = unit.rotation
      local velocity = unit.velocity
      local direction = vmath.normalize(velocity)
      local torque = unit.torque
      local sprites = unit.sprites

      local part = Unit(factory.create(self.spawner), {
        rotation = rotation,
        velocity = velocity + vmath.vector3(-direction.y, direction.x, direction.z) * config.SLICE_FORCE,
        torque = torque,
        radius = unit.radius,
        mass = unit.mass / 2,
        slicingable = true
      })

      local sprite = msg.url(nil, part.view, "sprite")
      msg.post(sprite, "play_animation", { id = sprites.partA })
      part:set_position(vmath.vector3(position.x - go.get(sprite, "size.x") / 2, position.y, position.z))
      table.insert(self.units, part)

      part = Unit(factory.create(self.spawner), {
        rotation = rotation,
        velocity = velocity + vmath.vector3(direction.y, -direction.x, direction.z) * config.SLICE_FORCE,
        torque = torque,
        radius = unit.radius,
        mass = unit.mass / 2,
        slicingable = true
      })

      sprite = msg.url(nil, part.view, "sprite")
      msg.post(sprite, "play_animation", { id = sprites.partB })
      part:set_position(vmath.vector3(position.x + go.get(sprite, "size.x") / 2, position.y, position.z))
      table.insert(self.units, part)

      unit:finalize()
      table.remove(self.units, index)

      self.eventbus.arbiter:emit(self.eventbus.events.ON_SLICED, unit)
    end
  end
end

function SliceSystem:inside_unit(unit)
  return vmath.length(self.slicer.position - unit.position) < self.slicer.radius + unit.radius
end

function SliceSystem:touch_start(data)
  self.slicer:set_position(self.camera.behaviour.screen_to_world(self.camera.id, data.pos))
  self.slicer.active = true
  self.slicer.slicing = false
end

function SliceSystem:touch_process(data)
  self.slicer:set_position(self.camera.behaviour.screen_to_world(self.camera.id, data.pos))
  self:is_slice(self.slicer.position)
end

function SliceSystem:touch_end(data)
  self.slicer.active = false
end

function SliceSystem:is_slice(position)
  local speed = vmath.length(position - self.slicer.previous_position)

  if speed < self.slicer.min_speed_for_slice then
    self.slicer.slicing = false
    return
  end

  self.slicer.slicing = true
end

return SliceSystem
