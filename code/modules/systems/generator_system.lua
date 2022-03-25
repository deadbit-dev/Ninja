local class = require "code.modules.utils.middleclass"
local Events = require "code.events"
local EventBus = require "code.modules.utils.eventbus"
local Math = require "code.modules.utils.math"
local Unit = require "code.modules.entities.unit"
local GeneratorSystem = class("GeneratorSystem")

function GeneratorSystem:initialize(units, packs)
  self.units = units
  self.packs = packs
  self.delay_pack = packs["1"].delay or 0
  self.duration_pack = packs["1"].duration or 0
  self.unit_by_pack = packs["1"].units or 0
  self.delay = packs["1"].delay or 0
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
 
  local unit = Unit(Math:get_random_value(self.units))
  unit.id = unit.id .. "#entire"

  EventBus:emit(Events.ON_GENERATED, {
    unit = unit
  })
end

return GeneratorSystem
