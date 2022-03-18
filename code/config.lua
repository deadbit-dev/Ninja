local Field = require "code.modules.utils.field"
local Pack = require "code.modules.cammon.pack"
local Zone = require "code.modules.cammon.zone"
local Point = require "code.modules.cammon.point"
local Unit = require "code.modules.cammon.unit"
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
    Point(vmath.vector3(0.0, 0.0, 0), -40),
    Point(vmath.vector3(1.0, 0.0, 0), 40),
    50
  ),
  Zone(
    Point(vmath.vector3(0.0, 0.0, 0), -40),
    Point(vmath.vector3(0.0, 0.25, 0), -55),
    25
  ),
  Zone(
    Point(vmath.vector3(1.0, 0.0, 0), 40),
    Point(vmath.vector3(1.0, 0.25, 0), 55),
    25
  )
})

config.DEFAULT_UNIT = {
  id = "unit",
  percent = 50,
  valocity = vmath.vector3(0),
  mass = 1
}

config.SPAWN_PACK = Pack("spawnpack", {
  Unit(config.DEFAULT_UNIT, {id = "apple"}),
  Unit(config.DEFAULT_UNIT, {id = "cherry"}),
  Unit(config.DEFAULT_UNIT, {id = "limon"}),
  Unit(config.DEFAULT_UNIT, {id = "pear"}),
  Unit(config.DEFAULT_UNIT, {id = "strawberry"}),
  Unit(config.DEFAULT_UNIT, {id = "watermelon"})
})

config.SPAWN_INTERVAL = 3
config.UNITS_BY_PACK = 2

return config