local EventBus = {}

EventBus.event_storage = {}
EventBus.handler_storage = {}

function EventBus:subscribe(event_id, subscriber, context)
  if not EventBus.event_storage[event_id] then 
    EventBus.event_storage[event_id] = {}
  end
  
  table.insert(EventBus.event_storage[event_id], subscriber)
 
  if type(subscriber) == "function" then
    EventBus.handler_storage[subscriber] = context
  end
end

function EventBus:unsubscribe(event_id, subscriber)
  local subscribers = EventBus.event_storage[event_id]

  if not subscribers then
    return
  end

  for index, value in ipairs(subscribers) do
    if value == subscriber then
      table.remove(subscribers, index)
    end
  end
end

function EventBus:emit(event_id, data)
  local subscribers = EventBus.event_storage[event_id]

  if not subscribers then
    return
  end

  for _, subscriber in ipairs(subscribers) do
    local type = type(subscriber)

    if type == "function" then
      subscriber(EventBus.handler_storage[subscriber], data)
    elseif type == "userdata" then
      msg.post(subscriber, event_id, data)
    end
  end
end

return EventBus