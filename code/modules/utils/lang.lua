local lang = {}

function lang:table_copy(orig)
  local copy = {}
  for orig_key, orig_value in pairs(orig) do
     copy[orig_key] = orig_value
  end
  return copy
end

return lang