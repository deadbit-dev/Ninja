local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local Effect = require "code.modules.entities.effect"
local EffectSystem = class("EffectSystem")

function EffectSystem:initialize(world, eventbus)
  self.eventbus = eventbus
  self.effects = world.state.context.effects
  self.spawner = world.entities.spawner

  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_SLICED, self.effector, self)
end

function EffectSystem:effector(data)
  self:splatter(data)
end

function EffectSystem:splatter(data)
  local splatter = Effect(factory.create(self.spawner), {
    position = vmath.vector3(data.position.x, data.position.y, config.SPLATTER_Z),
    rotation = vmath.vector3(0, 0, math.random(0, 360)),
    sprite = config.SPLATTERS[math.random(1, #config.SPLATTERS)]
  })

  local index = #self.effects + 1
  table.insert(self.effects, index, splatter)

  local sprite = msg.url(nil, splatter.id, "sprite")

  go.set(sprite, "tint", data.color)
  go.animate(
    sprite,
    "tint",
    go.PLAYBACK_ONCE_FORWARD,
    vmath.vector4(),
    go.EASING_INEXPO,
    config.SPLATTER_LIFE_TIME,
    0,
    function()
      splatter:finalize()
      table.remove(self.effects, index)
    end
  )
end

return EffectSystem