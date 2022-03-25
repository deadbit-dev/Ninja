local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local Math = require "code.modules.utils.math"
local Camera = require "code.modules.utils.camera"
local SpawnSystem = class("SpawnSystem")

function SpawnSystem:initialize(zones, gamefield, units)
  self.zones = zones
  self.gamefield = gamefield
  self.units = units
  EventBus:subscribe(Events.ON_GENERATED, self.spawn, self)
end

function SpawnSystem:spawn(data)
  local unit = data.unit
  local point = Math:get_random_value(self.zones):get_random_point()
  local pos = Camera:screen_to_field(point.pos, self.gamefield.camera_id, self.gamefield.camera)
  local angle = point.angle
  local force = math.random(point.min_force, point.max_force)
  local torque_force = math.random(point.torque_force_min, point.torque_force_max)

  unit:instantiate()
  unit:set_position(pos)
  unit.velocity = vmath.vector3(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0) * force
  unit.torque = torque_force

  table.insert(self.units, unit)
end

return SpawnSystem
