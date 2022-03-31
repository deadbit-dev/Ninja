local entities = {
  background = "bg",
  camera = {
    id = hash("/camera"),
    behaviour = require ("orthographic.camera")
  },
  spawner = "spawner#factory",
  slicer = require ("code.modules.entities.slicer")({
    view = "slicer",
    min_speed_for_slice = 10,
    radius = 5
  }),
}

return entities