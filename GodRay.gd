extends Sprite

export(bool) var use_day_cycle := false
export(Time.CycleState) var preferred_cycle := Time.CycleState.NIGHT
export(Color) var ray_color := Color("#ccffe6a6")


func _ready():
	material.set_shader_param("color", ray_color)
	if use_day_cycle:
		Time.connect("current_cycle_changed", self, "_set_enabled")
		_set_enabled(Time.current_cycle)
		
func _set_enabled(cycle):
	if cycle == preferred_cycle:
		show()
	else:
		hide()
