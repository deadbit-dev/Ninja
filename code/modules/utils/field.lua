local class = require "code.modules.utils.middleclass"
local camera = require "orthographic.camera"

local _private = setmetatable({}, {__mode = "k"})

local Field = class('Field')

function Field:initialize(camera_id)
  _private[self] = {
    camera_id = camera_id
  }
end

function Field:screen_to_field(pos)
  local camera_id = _private[self].camera_id
  local viewport = camera.get_viewport(camera_id)
  local screen = vmath.vector3(pos.x * viewport.z, pos.y * viewport.w, pos.z)

  return camera.screen_to_world(camera_id, screen)
end

return Field