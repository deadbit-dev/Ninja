local Generator = require "code.modules.spawn.generator"
local Spawner = require "code.modules.spawn.spawner"
local Zone = require "code.modules.spawn.zone"
local Point = require "code.modules.cammon.point"
local Pack = require "code.modules.cammon.pack"
local Element = require "code.modules.cammon.element"
local Field = require "code.modules.cammon.field"
local config = {}

-- Event
config.ON_LOAD_SCENE = hash("load_scene")
config.ON_INIT_SCENE = hash("init_scene")
config.ON_START_SCENE = hash("start_scene")

config.ON_START_SPAWN = hash("start_spawn")
config.ON_STOP_SPAWN = hash("stop_spawn")
config.ON_SPAWN_UNIT = hash("spawn_unit")

config.ON_SIMULATE_PHYSICS = hash("simulate_physics")
config.ON_STOP_PHYSICS = hash("stop_physics")

config.ON_ADD_FORCE = hash("add_force")

-- Spawn
config.SPAWN_ZONES = Pack("spawn_zones", {
  Element("bottom", Zone(
    Point(vmath.vector3(1.0, 0.0, 0), 55), 
    Point(vmath.vector3(1.0, 0.25, 0), 125)
  ), 70),
  Element("left", Zone(
    Point(vmath.vector3(0.0, 0.0, 0), 55), 
    Point(vmath.vector3(0.0, 0.25, 0), 35)
  ), 15),
  Element("right", Zone(
    Point(vmath.vector3(1.0, 0.0, 0), 125), 
    Point(vmath.vector3(1.0, 0.25, 0), 145)
  ), 15)
})

config.MODIFICATIONS = {
  velocity = vmath.vector3(),
  force = 350,
  mass = 25
}

config.UNITS = Pack("units", {
  Element("apple", config.MODIFICATIONS, 50),
  Element("cherry", config.MODIFICATIONS, 50),
  Element("limon", config.MODIFICATIONS, 50),
  Element("pear", config.MODIFICATIONS, 50),
  Element("strawberry", config.MODIFICATIONS, 50),
  Element("watermelon", config.MODIFICATIONS, 50)
})

-- DIFFICULT CURVES
config.SPAWN_INTERVAL_MIN = 3.5
config.SPAWN_INTERVAL_PLAYBACK = go.PLAYBACK_ONCE_FORWARD
config.SPAWN_INTERVAL_MAX = 2.5
config.SPAWN_INTERVAL_EASING = go.EASING_INOUTEXPO
config.SPAWN_INTERVAL_DURATION = 70

config.UNITS_SPAWN_MIN = 1
config.UNITS_SPAWN_PLAYBACK = go.PLAYBACK_ONCE_FORWARD
config.UNITS_SPAWN_MAX = 5
config.UNITS_SPAWN_EASING = go.EASING_INOUTEXPO
config.UNITS_SPAWN_DURATION = 30

-- Physics
config.GRAVITY = 9.8
config.AXIS_GRAVITY = vmath.vector3(0, -1, 0)

-- Object
config.CAMERA = hash("/camera")
config.GAME_FIELD = Field(config.CAMERA)
config.GENERATOR = Generator(config.UNITS)
config.SPAWNER = Spawner(config.GAME_FIELD, config.SPAWN_ZONES)

return config
