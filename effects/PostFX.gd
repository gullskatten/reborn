extends ColorRect

export(Color) var color1_dusk = Color("#fff")
export(Color) var color2_dusk = Color("#fff")
export(Color) var color1_dawn = Color("#fff")
export(Color) var color2_dawn = Color("#fff")
export(Color) var color1_night = Color("#fff")
export(Color) var color2_night = Color("#fff")
export(Color) var color1_day = Color("#fff")
export(Color) var color2_day = Color("#fff")

func _ready():
	Time.connect("current_cycle_changed", self, "_set_color_fx")

func _set_color_fx(cycle):
	if cycle == Time.CycleState.DAWN:
		material.set_shader_param("color1", color1_dawn)
		material.set_shader_param("color2", color2_dawn)
	elif cycle == Time.CycleState.DUSK:
		material.set_shader_param("color1", color1_dusk)
		material.set_shader_param("color2", color2_dusk)
	elif cycle == Time.CycleState.NIGHT:
		material.set_shader_param("color1", color1_night)
		material.set_shader_param("color2", color2_night)
	elif cycle == Time.CycleState.DAY:
		material.set_shader_param("color1", color1_day)
		material.set_shader_param("color2", color2_day)
