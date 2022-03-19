local Generator = require "code.modules.spawn.generator"
local Spawner = require "code.modules.spawn.spawner"
local Zone = require "code.modules.spawn.zone"
local Point = require "code.modules.cammon.point"
local Pack = require "code.modules.cammon.pack"
local Unit = require "code.modules.cammon.unit"
local Field = require "code.modules.cammon.field"
local config = {}

-- Event
config.ON_LOAD_SCENE = hash("load_scene")
config.ON_INIT_SCENE = hash("init_scene")
config.ON_START_SCENE = hash("start_scene")

config.ON_START_SPAWN = hash("start_spawn")
config.ON_STOP_SPAWN = hash("stop_spawn")
config.ON_SPAWN_UNIT = hash("spawn_unit")

-- Spawn
config.SPAWN_ZONES = Pack(nil, {
  { 
    value = Zone(
      Point(vmath.vector3(0.0, 0.0, 0), -40), 
      Point(vmath.vector3(1.0, 0.0, 0), 40)
    ), 
    weight = 50
  },
  {
    value = Zone(
      Point(vmath.vector3(0.0, 0.0, 0), -40), 
      Point(vmath.vector3(0.0, 0.25, 0), -55)
    ), 
    weight = 25
  },
  {
    value = Zone(
      Point(vmath.vector3(1.0, 0.0, 0), 40), 
      Point(vmath.vector3(1.0, 0.25, 0), 55)
    ), 
    weight = 25
  }
})

config.DEFAULT_UNIT = {
  valocity = vmath.vector3(0),
  mass = 1
}

config.UNITS = Pack("units", {
  { value = Unit("apple", config.DEFAULT_UNIT), weight = 50 },
  { value = Unit("cherry", config.DEFAULT_UNIT), weight = 50 },
  { value = Unit("limon", config.DEFAULT_UNIT), weight = 50 },
  { value = Unit("pear", config.DEFAULT_UNIT), weight = 50 },
  { value = Unit("strawberry", config.DEFAULT_UNIT), weight = 50 },
  { value = Unit("watermelon", config.DEFAULT_UNIT), weight = 50 }
})

-- DIFFICULT CURVES
config.SPAWN_INTERVAL_MIN = 5
config.SPAWN_INTERVAL_PLAYBACK = go.PLAYBACK_ONCE_FORWARD
config.SPAWN_INTERVAL_MAX = 2.5
config.SPAWN_INTERVAL_EASING = go.EASING_INOUTEXPO
config.SPAWN_INTERVAL_DURATION = 50

config.UNITS_SPAWN_MIN = 1
config.UNITS_SPAWN_PLAYBACK = go.PLAYBACK_ONCE_FORWARD
config.UNITS_SPAWN_MAX = 5
config.UNITS_SPAWN_EASING = go.EASING_INOUTEXPO
config.UNITS_SPAWN_DURATION = 25

-- Object
config.CAMERA = hash("/camera")
config.GAME_FIELD = Field(config.CAMERA)
config.GENERATOR = Generator(config.UNITS)
config.SPAWNER = Spawner(config.GAME_FIELD, config.SPAWN_ZONES)

return config