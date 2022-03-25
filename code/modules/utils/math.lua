local Math = {}

function Math.sum(array)
  local acc = 0

  for _, value in ipairs(array) do
    acc = acc + value
  end

  return acc
end

function Math.random_range_weight(weights)
  local point = math.random() * Math.sum(weights)

  for i, value in ipairs(weights) do
    if point < value then
      return i
    end

    point = point - value
  end

  return #weights
end

function Math:get_random_value(elements)
  local weights = {}
  for i = 1, #elements do
    table.insert(weights, i, elements[i].weight or 50)
  end
  
  return elements[Math.random_range_weight(weights)]
end

return Math