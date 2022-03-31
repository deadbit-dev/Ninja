local class = require "code.modules.utils.middleclass"
local ScoreSystem = class("ScoreSystem")

function ScoreSystem:initialize(world, eventbus)
  self.eventbus = eventbus
  self.current = world.state.context.scores.current
  self.best = world.state.context.scores.best

  self.eventbus.arbiter:subscribe(self.eventbus.events.ON_SLICED, self.score, self)
end

function ScoreSystem:score(data)
  if not data.score then
    return
  end

  self:add_score(data.score)
  self.eventbus.arbiter:emit(self.eventbus.events.ON_SCORED, {position = data.position})
end

function ScoreSystem:add_score(score)
  self.current = self.current + score

  if self.current > self.best then
    self.best = self.current
  end
end

return ScoreSystem
