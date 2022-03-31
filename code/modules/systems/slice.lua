local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local Part = require "code.modules.entities.part"
local SliceSystem = class("SliceSystem")

function SliceSystem:initialize(world, eventbus)
  self.eventbus = eventbus
  self.units = world.state.context.units
  self.camera = world.entities.camera
  self.spawner = world.entities.spawner
  self.slicer = world.entities.slicer

  self.eventbus.arbiter:subscribe(
    self.eventbus.events.ON_TOUCH_START,
    self.touch_start,
    self
  )
  self.eventbus.arbiter:subscribe(
    self.eventbus.events.ON_TOUCH_PROCESS,
    self.touch_process,
    self
  )
  self.eventbus.arbiter:subscribe(
    self.eventbus.events.ON_TOUCH_END,
    self.touch_end,
    self
  )
end

function SliceSystem:touch_start(data)
  self.slicer:set_position(
    self.camera.behaviour.screen_to_world(self.camera.id, data.pos)
  )
  self.slicer.active = true
  self.slicer.slicing = false
end

function SliceSystem:touch_process(data)
  self.slicer:set_position(
    self.camera.behaviour.screen_to_world(self.camera.id, data.pos)
  )
  self:try_slice(self.slicer.position)
end

function SliceSystem:touch_end(data)
  self.slicer.active = false
end

function SliceSystem:try_slice(position)
  local speed = vmath.length(position - self.slicer.previous_position)

  if speed < self.slicer.min_speed_for_slice then
    self.slicer.slicing = false
    return
  end

  self.slicer.slicing = true
end

function SliceSystem:inside_unit(unit)
  return vmath.length(self.slicer.position - unit.position) < self.slicer.radius + unit.radius
end

function SliceSystem:update(dt)
  if not self.slicer.slicing then
    return
  end

  for index, unit in ipairs(self.units) do
    if self:inside_unit(unit) and unit.class.name == "Unit" then
      self:slice(unit)
      unit:finalize()
      table.remove(self.units, index)
    end
  end
end

function SliceSystem:slice(unit)
  local position = unit.position
  local rotation = unit.rotation
  local radius = unit.radius
  local mass = unit.mass
  local velocity = unit.velocity
  local torque = unit.torque
  local parts = unit.parts
  local direction = vmath.normalize(velocity)

  local part = Part(factory.create(self.spawner), {
    position = position,
    rotation = rotation,
    velocity = velocity + vmath.vector3(-direction.y, direction.x, direction.z) * config.SLICE_FORCE,
    torque = torque,
    radius = radius,
    mass = mass / 2,
    sprite = parts.left
  })
  -- part:set_position(vmath.vector3(position.x + go.get(sprite, "size.x") / 2, position.y, position.z))
  table.insert(self.units, part)

  part = Part(factory.create(self.spawner), {
    position = position,
    rotation = rotation,
    velocity = velocity + vmath.vector3(direction.y, -direction.x, direction.z) * config.SLICE_FORCE,
    torque = torque,
    radius = radius,
    mass = mass / 2,
    sprite = parts.right
  })
  -- part:set_position(vmath.vector3(position.x + go.get(sprite, "size.x") / 2, position.y, position.z))
  table.insert(self.units, part)

  self.eventbus.arbiter:emit(self.eventbus.events.ON_SLICED, unit)
end

return SliceSystem
