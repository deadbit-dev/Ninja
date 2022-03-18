local Field = require "code.modules.utils.field"
local Pack = require "code.modules.spawn.pack"
local Zone = require "code.modules.spawn.zone"
local Point = require "code.modules.spawn.point"
local Unit = require "code.modules.spawn.unit"
local config = {}

-- Event
config.ON_LOAD_SCENE = hash("load_scene")
config.ON_INIT_SCENE = hash("init_scene")
config.ON_START_SCENE = hash("start_scene")

config.ON_START_SPAWN = hash("start_spawn")
config.ON_STOP_SPAWN = hash("stop_spawn")
config.ON_SPAWN_UNIT = hash("spawn_unit")

-- Object
config.CAMERA = hash("/camera")
config.GAME_FIELD = Field(config.CAMERA)

-- Spawn
config.SPAWN_ZONES = Pack("", {
  Zone(
    Point(vmath.vector3(0.0, 0.0, 0), 50.0),
    Point(vmath.vector3(1.0, 0.0, 0), 130.0),
    50
  ),
  Zone(
    Point(vmath.vector3(0.0, 0.0, 0), 50.0),
    Point(vmath.vector3(0.0, 0.25, 0), 35.0),
    25
  ),
  Zone(
    Point(vmath.vector3(1.0, 0.0, 0), 130.0),
    Point(vmath.vector3(1.0, 0.25, 0), 145.0),
    25
  )
})

config.SPAWN_PACK = Pack("spawnpack", {
  Unit("apple", 50),
  Unit("cherry", 50),
  Unit("limon", 50),
  Unit("pear", 50),
  Unit("strawberry", 50),
  Unit("watermelon", 50)
})

config.SPAWN_INTERVAL = 3
config.UNITS_BY_PACK = 1

return config