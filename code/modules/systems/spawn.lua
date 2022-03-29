local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local Math = require "code.modules.utils.math"
local Camera = require "code.modules.utils.camera"
local Unit = require "code.modules.entities.unit"
local SpawnSystem = class("SpawnSystem")

function SpawnSystem:initialize(state, eventbus)
  self.eventbus = eventbus
  self.camera = state.context.camera
  self.spawner = state.context.spawner
  self.units = state.context.units

  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_GENERATED, self.spawn, self)
end

function SpawnSystem:spawn(data)
  local point = Math:get_random_value(config.SPAWN_ZONES):get_random_point()
  local position = Camera:viewport_to_world(point.pos, self.camera.id, self.camera.behaviour)
  local angle = point.angle
  local force = math.random(point.min_force, point.max_force)

  local unit = Unit(factory.create(self.spawner), data)

  unit:set_position(position)
  unit.velocity = vmath.vector3(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0) * force
  unit.torque = math.random(point.torque_force_min, point.torque_force_max)

  msg.post(msg.url(nil, unit.view, "sprite"), "play_animation", { id = data.sprites.entire })
  table.insert(self.units, unit)
end

return SpawnSystem
