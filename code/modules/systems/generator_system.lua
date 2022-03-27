local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local Math = require "code.modules.utils.math"

local GeneratorSystem = class("GeneratorSystem")

function GeneratorSystem:initialize(config)
  self.packs = config.SPAWN_PACK
  self.units = config.UNITS
  self.delay_pack = self.packs["1"].delay or 0
  self.duration_pack = self.packs["1"].duration or 0
  self.unit_by_pack = self.packs["1"].units or 0
  self.delay = self.packs["1"].delay or 0
  self.timer = 0
  self.counter_pack = 1
  self.counter_unit = 1
 end

function GeneratorSystem:update(dt)
  if self.delay > self.timer then
    self.timer = self.timer + dt
    return
  end

  self.timer = 0
  
  if self.counter_unit == self.unit_by_pack then
    self.counter_pack = self.counter_pack + 1

    local pack = self.packs[tostring(self.counter_pack)]

    if pack then
      self.delay_pack = pack.delay or self.delay_pack
      self.duration_pack = pack.duration or self.duration_pack
      self.unit_by_pack = pack.units or self.duration_pack
    end

    self.delay = self.delay_pack
    self.counter_unit = 1
  else
    self.counter_unit = self.counter_unit + 1
    self.delay = self.duration_pack / self.unit_by_pack
  end
 
  EventBus:emit(Events.ON_GENERATED, {
    unit = Math:get_random_value(self.units)
  })
end

return GeneratorSystem
