local M = {}

local event_storage = {}

function M.subscribe(event, subscriber)
  if not event_storage[event] then 
    event_storage[event] = {}
  end

  table.insert(event_storage[event], subscriber)
end

function M.unsubscribe(event, subscriber)
  local subscribers = event_storage[event]
  
  for index, value in ipairs(subscribers) do
    if value == subscriber then
      table.remove(subscribers, index)
    end
  end
end

function M.emit(event, data)
  local subscribers = event_storage[event]

  for _, subscriber in ipairs(subscribers) do
    msg.post(subscriber, event, data)
  end
end

return M