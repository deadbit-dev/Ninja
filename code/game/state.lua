local state = {}

state.context = {
   generator = {
    timer = 0,
    delay = 0,
    counter_pack = 0,
    counter_unit = 0
  },
  pack = {
    delay = 0,
    duration = 0,
    units = 0
  },
  health = 0,
  scores = {
    current = 0,
    best = 0
  },
  effects = {},
  units = {}
}

return state