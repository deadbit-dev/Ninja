local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local Math = require "code.modules.utils.math"
local GeneratorSystem = class("GeneratorSystem")

function GeneratorSystem:initialize(state, eventbus)
  self.eventbus = eventbus
  self.generator = state.context.generator
  self.pack = state.context.pack
end

function GeneratorSystem:update(dt)

  if self.generator.delay > self.generator.timer then
    self.generator.timer = self.generator.timer + dt
    return
  end

  self.generator.timer = 0

  if self.generator.counter_unit == self.pack.units then
    self.generator.counter_pack = self.generator.counter_pack + 1

    local next_pack = config.SPAWN_PACKS[tostring(self.generator.counter_pack)]

    if next_pack then
      self.pack.delay = next_pack.delay or self.pack.delay
      self.pack.duration = next_pack.duration or self.pack.duration
      self.pack.units = next_pack.units or self.pack.units
    end

    self.generator.delay = self.pack.delay
    self.generator.counter_unit = 1
  else
    self.generator.counter_unit = self.generator.counter_unit + 1
    self.generator.delay = self.pack.duration / self.pack.units
  end

  self.eventbus.arbiter:emit(self.eventbus.events.ON_GENERATED, Math:get_random_value(config.SPAWN_UNITS))
end

return GeneratorSystem
