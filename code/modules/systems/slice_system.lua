local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local Unit = require "code.modules.entities.unit"
local SliceSystem = class("SliceSystem")

function SliceSystem:initialize(state, config)
  self.camera = config.CAMERA
  self.slicer = config.SLICER
  self.slice_force = config.SLICE_FORCE
  self.spawner = config.SPAWNER
  self.units = state.context.units
  self.previous_position = self.slicer.position

  EventBus:subscribe(Events.ON_TOUCH_START, self.touch_start, self)
  EventBus:subscribe(Events.ON_TOUCH_PROCESS, self.touch_process, self)
  EventBus:subscribe(Events.ON_TOUCH_END, self.touch_end, self)
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
      local torque = unit.torque
      local sprites = unit.sprites

      local direction = vmath.normalize(velocity)

      local partA = Unit({
        view = factory.create(self.spawner),
        rotation = rotation,
        velocity = velocity + vmath.vector3(-direction.y, direction.x, direction.z) * self.slice_force,
        torque = torque,
        slicingable = true
      })

      local spriteA = msg.url(nil, partA.view, "sprite")
      msg.post(spriteA, "play_animation", { id = sprites.partA })
      local posA = vmath.vector3(position.x - go.get(spriteA, "size.x") / 2, position.y, position.z)
      partA:set_position(posA)
      table.insert(self.units, partA)

      local partB = Unit({
        view = factory.create(self.spawner),
        rotation = rotation,
        velocity = velocity + vmath.vector3(direction.y, -direction.x, direction.z) * self.slice_force,
        torque = torque,
        slicingable = true
      })

      local spriteB = msg.url(nil, partB.view, "sprite")
      msg.post(spriteB, "play_animation", { id = sprites.partB })
      local posB = vmath.vector3(position.x + go.get(spriteB, "size.x") / 2, position.y, position.z)
      partB:set_position(posB)
      table.insert(self.units, partB)

      unit:finalize()
      table.remove(self.units, index)
    end
  end
end

function SliceSystem:inside_unit(unit)
  return vmath.length(self.slicer.position - unit.position) < self.slicer.radius + unit.radius
end

function SliceSystem:touch_start(data)
  self.slicer:set_position(self.camera.bihavour.screen_to_world(self.camera.id, data.pos))
  self.previous_position = self.slicer.position
  self.slicer.active = true
  self.slicer.slicing = false
end

function SliceSystem:touch_process(data)
  self.slicer:set_position(self.camera.bihavour.screen_to_world(self.camera.id, data.pos))
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
