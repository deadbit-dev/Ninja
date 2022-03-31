local class = require "code.modules.utils.middleclass"
local View = class('View')

function View:initialize(id, args)
  self.id = id
  self.position = args.position or vmath.vector3()
  self.rotation = args.rotation or vmath.vector3()
  self.scale = args.scale or vmath.vector3(1)
  self.sprite = args.sprite

  go.set_position(self.position, self.id)
  go.set(self.id, "euler", self.rotation)
  go.set_scale(self.scale, self.id)
  msg.post(msg.url(nil, self.id, "sprite"), "play_animation", {
    id = self.sprite
  })
end

function View:set_position(position)
  self.position = position
  go.set_position(position, self.id)
end

function View:set_rotation(rotation)
  self.rotation = rotation
  go.set(self.id, "euler", rotation)
end

function View:set_scale(scale)
  self.scale = scale
  go.set_scale(scale, self.id)
end

function View:set_sprite(sprite)
  self.sprite = sprite
  msg.post(msg.url(nil, self.id, "sprite"), "play_animation", {
    id = sprite
  })
end

function View:finalize()
  go.delete(self.id)
end

return View

