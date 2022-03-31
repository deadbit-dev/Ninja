local Spawn = require "code.modules.entities.spawn"
local config = {}

config.WIDTH = 960
config.HEIGHT = 640

config.GRAVITY = 9.8
config.GRAVITY_AXIS = vmath.vector3(0, -1, 0)

config.MAX_HEALTH = 5

config.SPLATTER_LIFE_TIME = 2.5
config.SPLATTER_Z = -5

config.SLICE_FORCE = 50

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

config.PACKS = {
  ["1"] = { delay = 3, duration = 1, units = 1 },
  ["3"] = { units = 2 },
  ["5"] = { units = 3 },
  ["10"] = { duration = 2, units = 5 },
  ["20"] = { delay = 1 }
}

local DEFAULT_UNIT_RADIUS = 40
local DEFAULT_UNIT_MASS = 50
local DEFAULT_UNIT_SCORE = 10

config.UNITS = {
  {
    sprite = hash("apple"),
    parts = {
      left = hash("apple_partA"),
      right = hash("apple_partB")
    },
    radius = DEFAULT_UNIT_RADIUS,
    mass = DEFAULT_UNIT_MASS,
    score = DEFAULT_UNIT_SCORE,
    color = vmath.vector4(0, 1, 0, 1)
  },
  {
    sprite = hash("cherry"),
    parts = {
      left = hash("cherry_partA"),
      right = hash("cherry_partB")
    },
    radius = DEFAULT_UNIT_RADIUS,
    mass = DEFAULT_UNIT_MASS,
    score = DEFAULT_UNIT_SCORE,
    color = vmath.vector4(1, 0, 0, 1)
  },
  {
    sprite = hash("limon"),
    parts = {
      left = hash("limon_partA"),
      right = hash("limon_partB")
    },
    radius = DEFAULT_UNIT_RADIUS,
    mass = DEFAULT_UNIT_MASS,
    score = DEFAULT_UNIT_SCORE,
    color = vmath.vector4(1, 1, 0, 1)
  },
  {
    sprite = hash("pear"),
    parts = {
      left = hash("pear_partA"),
      right = hash("pear_partB")
    },
    radius = DEFAULT_UNIT_RADIUS,
    mass = DEFAULT_UNIT_MASS,
    score = DEFAULT_UNIT_SCORE,
    color = vmath.vector4(1, 1, 0, 1)
  },
  {
    sprite = hash("watermelon"),
    parts = {
      left = hash("watermelon_partA"),
      right = hash("watermelon_partB")
    },
    radius = 60,
    mass = DEFAULT_UNIT_MASS,
    score = DEFAULT_UNIT_SCORE,
    color = vmath.vector4(1, 0, 0, 1)
  },
  -- {
  --   sprite = hash("heart"),
  --   parts = {
  --     left = hash("heart_partA"),
  --     right = hash("heart_partB")
  --   },
  --   radius = DEFAULT_UNIT_RADIUS,
  --   mass = DEFAULT_UNIT_MASS,
  --   color = vmath.vector4(1, 0, 0, 1),
  --   healing = 1,
  --   weight = 0.3
  -- },
  -- {
  --   sprite = hash("bomb"),
  --   radius = DEFAULT_UNIT_RADIUS,
  --   mass = DEFAULT_UNIT_MASS,
  --   damage = 1,
  --   weight = 0.3
  -- }
}

config.SPLATTERS = {
  hash("splatter_0"),
  hash("splatter_1")
}

return config
