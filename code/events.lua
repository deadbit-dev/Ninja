local events = {}

events.ON_LOAD = hash("load")
events.ON_TOUCH_START = hash("touch_start")
events.ON_TOUCH_PROCESS = hash("touch_process")
events.ON_TOUCH_END = hash("touch_end")
events.ON_GENERATED = hash("generated")
events.ON_SLICED = hash("sliced")
events.ON_SCORED = hash("scored")

return events