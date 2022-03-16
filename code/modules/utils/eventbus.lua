local class = require "code.modules.utils.middleclass"
local EventBus = class('EventBus')

EventBus.static.event_storage = {}

function EventBus.static:subscribe(event, subscriber)
  if not EventBus.event_storage[event] then 
    EventBus.event_storage[event] = {}
  end

  table.insert(EventBus.event_storage[event], subscriber)
end

function EventBus.static:unsubscribe(event, subscriber)
  local subscribers = EventBus.event_storage[event]
  
  for index, value in ipairs(subscribers) do
    if value == subscriber then
      table.remove(subscribers, index)
    end
  end
end

function EventBus.static:emit(event, data)
  local subscribers = EventBus.event_storage[event]

  for _, subscriber in ipairs(subscribers) do
    msg.post(subscriber, event, data)
  end
end

return EventBus