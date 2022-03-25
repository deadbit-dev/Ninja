local Spawn = require "code.modules.utils.spawn"
local Slicer = require "code.modules.entities.slicer"
local config = {}

config.SPAWN_ZONES = {
  Spawn.Zone(
    Spawn.Point(vmath.vector3(0.0, 0.0, 0), 65, 300, 350), 
    Spawn.Point(vmath.vector3(1.0, 0.0, 0), 115, 300, 350),
    60
  ),
  Spawn.Zone(
    Spawn.Point(vmath.vector3(0.0, 0.0, 0), 65, 300, 350), 
    Spawn.Point(vmath.vector3(0.0, 0.25, 0), 35, 250, 300),
    20
  ),
  Spawn.Zone(
    Spawn.Point(vmath.vector3(1.0, 0.0, 0), 115, 300, 350), 
    Spawn.Point(vmath.vector3(1.0, 0.25, 0), 145, 250, 300),
    20
  )
}

config.UNITS = {
  { id = "apple"},
  { id = "cherry"},
  { id = "limon"},
  { id = "pear"},
  { id = "strawberry"},
  { id = "watermelon"}
}

config.SPAWN_PACK = {
  ["1"] = { delay = 3, duration = 1, units = 1 },
  ["3"] = { units = 2 },
  ["5"] = { units = 3 },
  ["10"] = { duration = 2, units = 5 },
  ["20"] = { delay = 1 }
}

config.GAMEFIELD = {
  camera = require "orthographic.camera",
  camera_id = hash("/camera")
}

config.SLICER = Slicer({
  id = hash("slicer"),
  min_speed_for_slice = 10,
  radius = 5
})

return config
