local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local Math = require "code.modules.utils.math"
local Camera = require "code.modules.utils.camera"
local Unit = require "code.modules.entities.unit"
local SpawnSystem = class("SpawnSystem")

function SpawnSystem:initialize(state, config)
  self.zones = config.SPAWN_ZONES
  self.gamefield = config.GAMEFIELD
  self.units = state.context.units
  EventBus:subscribe(Events.ON_GENERATED, self.spawn, self)
end

function SpawnSystem:spawn(data)
  local point = Math:get_random_value(self.zones):get_random_point()
  local pos = Camera:screen_to_field(point.pos, self.gamefield.camera_id, self.gamefield.camera)

  -- pprint("POINT: ", point)
  -- pprint("WORLD: ", pos)

  local angle = point.angle
  local force = math.random(point.min_force, point.max_force)
  local torque_force = math.random(point.torque_force_min, point.torque_force_max)

  local unit = Unit({ view = factory.create("unit#factory") })
  msg.post(msg.url(nil, unit.view, "sprite"), "play_animation", { id = data.unit.view })

  unit:set_position(pos)
  unit.velocity = vmath.vector3(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0) * force
  unit.torque = torque_force

  table.insert(self.units, unit)
end

return SpawnSystem
