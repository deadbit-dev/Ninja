local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local Math = require "code.modules.utils.math"
local Camera = require "code.modules.utils.camera"
local Unit = require "code.modules.entities.unit"
local SpawnSystem = class("SpawnSystem")

function SpawnSystem:initialize(state, config)
  self.spawner = config.SPAWNER
  self.zones = config.SPAWN_ZONES
  self.camera = config.CAMERA
  self.units = state.context.units
  EventBus:subscribe(Events.ON_GENERATED, self.spawn, self)
end

function SpawnSystem:spawn(data)
  local point = Math:get_random_value(self.zones):get_random_point()
  local position = Camera:viewport_to_world(point.pos, self.camera.id, self.camera.bihavour)
  local angle = point.angle
  local force = math.random(point.min_force, point.max_force)

  local unit = Unit({ 
    view = factory.create(self.spawner),
    position = position,
    velocity = vmath.vector3(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0) * force,
    torque = math.random(point.torque_force_min, point.torque_force_max),
    sprites = data.sprites
  })

  msg.post(msg.url(nil, unit.view, "sprite"), "play_animation", { id = data.sprites.entire })
  table.insert(self.units, unit)
end

return SpawnSystem
