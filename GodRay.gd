extends Sprite

export(bool) var use_day_cycle := false
export(InTime.CycleState) var preferred_cycle := InTime.CycleState.NIGHT
export(Color) var ray_color := Color("#ccffe6a6")


func _ready():
	material.set_shader_param("color", ray_color)
	if use_day_cycle:
		InTime.connect("current_cycle_changed", self, "_set_enabled")
		_set_enabled(InTime.current_cycle)
		
func _set_enabled(cycle):
	if cycle == preferred_cycle:
		show()
	else:
		hide()
