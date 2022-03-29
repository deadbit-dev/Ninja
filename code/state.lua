local config = require "code.config"
local state = {}

state.context = {
  camera = {
    id = hash("/camera"),
    behaviour = require ("orthographic.camera")
  },
  generator = {
    timer = 0,
    delay = config.SPAWN_PACKS["1"].delay,
    counter_pack = 1,
    counter_unit = 1
  },
  pack = config.SPAWN_PACKS["1"],
  spawner = "spawner#factory",
  slicer = require ("code.modules.entities.slicer")({
    view = "slicer",
    min_speed_for_slice = 10,
    radius = 5
  }),
  splatters = {},
  units = {}
}

return state