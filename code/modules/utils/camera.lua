local Camera = {}

function Camera:viewport_to_world(pos, camera_id, camera)
  local viewport = camera.get_viewport(camera_id)
  local window = vmath.vector3(pos.x * viewport.z, pos.y * viewport.w, pos.z)
  return camera.window_to_world(camera_id, window)
end

return Camera