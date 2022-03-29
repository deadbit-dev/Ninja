local Spawn = require "code.modules.entities.spawn"
local config = {}

config.SPAWN_PACKS = {
  ["1"] = { delay = 3, duration = 1, units = 1 },
  ["3"] = { units = 2 },
  ["5"] = { units = 3 },
  ["10"] = { duration = 2, units = 5 },
  ["20"] = { delay = 1 }
}

config.SPAWN_ZONES = {
  Spawn.Zone(
    Spawn.Point(vmath.vector3(0.0, 0.0, 0), 65, 500, 550),
    Spawn.Point(vmath.vector3(1.0, 0.0, 0), 115, 500, 550),
    60
  ),
  Spawn.Zone(
    Spawn.Point(vmath.vector3(0.0, 0.0, 0), 65, 500, 550),
    Spawn.Point(vmath.vector3(0.0, 0.25, 0), 35, 450, 500),
    20
  ),
  Spawn.Zone(
    Spawn.Point(vmath.vector3(1.0, 0.0, 0), 115, 500, 550),
    Spawn.Point(vmath.vector3(1.0, 0.25, 0), 145, 450, 500),
    20
  )
}

local DEFAULT_RADIUS = 40
local DEFAULT_MASS = 50

config.SPAWN_UNITS = {
  {
    sprites = {
      entire = hash("apple"),
      partA = hash("apple_partA"),
      partB = hash("apple_partB")
    },
    color = vmath.vector4(0, 1, 0, 1),
    radius = DEFAULT_RADIUS,
    mass = DEFAULT_MASS
  },
  {
    sprites = {
      entire = hash("cherry"),
      partA = hash("cherry_partA"),
      partB = hash("cherry_partB")
    },
    color = vmath.vector4(1, 0, 0, 1),
    radius = DEFAULT_RADIUS,
    mass = DEFAULT_MASS
  },
  {
    sprites = {
      entire = hash("limon"),
      partA = hash("limon_partA"),
      partB = hash("limon_partB")
    },
    color = vmath.vector4(1, 1, 0, 1),
    radius = DEFAULT_RADIUS,
    mass = DEFAULT_MASS
  },
  {
    sprites = {
      entire = hash("pear"),
      partA = hash("pear_partA"),
      partB = hash("pear_partB")
    },
    color = vmath.vector4(1, 1, 0, 1),
    radius = DEFAULT_RADIUS,
    mass = DEFAULT_MASS
  },
  {
    sprites = {
      entire = hash("strawberry"),
      partA = hash("strawberry_partA"),
      partB = hash("strawberry_partB")
    },
    color = vmath.vector4(1, 0, 0, 1),
    radius = DEFAULT_RADIUS,
    mass = DEFAULT_MASS
  },
  {
    sprites = {
      entire = hash("watermelon"),
      partA = hash("watermelon_partA"),
      partB = hash("watermelon_partB")
    },
    color = vmath.vector4(1, 0, 0, 1),
    radius = DEFAULT_RADIUS,
    mass = DEFAULT_MASS
  }
}

config.SPLATTERS = {
  hash("splatter_0"),
  hash("splatter_1")
}

config.SPLATTER_LIFE_TIME = 2.5
config.SPLATTER_Z = -5

config.SLICE_FORCE = 25

config.GRAVITY = 9.8
config.GRAVITY_AXIS = vmath.vector3(0, -1, 0)

return config
