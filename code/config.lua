local SpawnZone = require "modules.spawn.spawnzone"
local SpawnPack = require "modules.spawn.spawnzone"
local config = {}

-- Objects
config.MENU = hash("menu")
config.GAME = hash("game")
config.CAMERA = hash("/camera")

-- Events
config.ON_LOAD_SCENE = hash("load_scene")
config.ON_SPAWN_START = hash("spawn_start")
config.ON_SPAWN_END = hash("spawn_end")
config.ON_SPAWN_PACK = hash("spawn_pack")
config.ON_SPAWN_UNIT = hash("spawn_unit")

-- SpawnZones
config.SPAWN_ZONES = {
  BOTTOM = SpawnZone(
    vmath.vector3(0.0, 0.0, 50.0),
    vmath.vector3(1.0, 0.0, 130.0)
  ),
  LEFT = SpawnZone(
    vmath.vector3(0.0, 0.0, 50.0),
    vmath.vector3(0.0, 0.25, 35.0)
  ),
  RIGHT = SpawnZone(
    vmath.vector3(1.0, 0.0, 130.0),
    vmath.vector3(1.0, 0.25, 145.0)
  )
}

-- SpawnInfo
config.SPAWN_INTERVAL = 2.5
config.UNITS_BY_PACK = 5

-- SpawnPack
config.SPAWN_PACK = SpawnPack({

})

return config