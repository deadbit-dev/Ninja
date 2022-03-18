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

return Math