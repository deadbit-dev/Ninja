local Camera = {}

function Camera:viewport_to_world(pos, camera_id, camera)
  local viewport = camera.get_viewport(camera_id)
  local screen = vmath.vector3(pos.x * viewport.z, pos.y * viewport.w, pos.z)

  return camera.screen_to_world(camera_id, screen)
end

return Camera