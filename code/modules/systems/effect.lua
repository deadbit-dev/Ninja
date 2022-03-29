local class = require "code.modules.utils.middleclass"
local config = require "code.config"
local Unit = require "code.modules.entities.unit"
local EffectSystem = class("EffectSystem")

function EffectSystem:initialize(state, eventbus)
  self.eventbus = eventbus
  self.spawner = state.context.spawner
  self.splatters = state.context.splatters

  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_SLICED, self.effector, self)
end

function EffectSystem:effector(data)
  self:splatter(data)
end

function EffectSystem:splatter(data)
  local splatter = Unit(factory.create(self.spawner), {
    position = vmath.vector3(data.position.x, data.position.y, config.SPLATTER_Z),
    rotation = vmath.vector3(0, 0, math.random(0, 360))
  })

  local index = #self.splatters + 1
  table.insert(self.splatters, index, splatter)

  local sprite = msg.url(nil, splatter.view, "sprite")
  msg.post(sprite, "play_animation", {
    id = config.SPLATTERS[math.random(1, #config.SPLATTERS)]
  })

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
      table.remove(self.splatters, index)
    end
  )
end

return EffectSystem