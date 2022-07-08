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

func _transition_colors(color1_from, color1_to, color2_from, color2_to):
		$TweenColor1.interpolate_property(
					material,
					"shader_param/color1",
					color1_from,
					color1_to,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
		$TweenColor1.start()
		
		$TweenColor2.interpolate_property(
					material,
					"shader_param/color2",
					color2_from,
					color2_to,
					Time.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
		$TweenColor2.start()

func _set_color_fx(cycle):
	if cycle == Time.CycleState.DAWN:
		_transition_colors(color1_night, color1_dawn, color2_night, color2_dawn)
	elif cycle == Time.CycleState.DUSK:
		_transition_colors(color1_day, color1_dusk, color2_day, color2_dusk)
	elif cycle == Time.CycleState.NIGHT:
		_transition_colors(color1_dusk, color1_night, color2_dusk, color2_night)
	elif cycle == Time.CycleState.DAY:
		_transition_colors(color1_dawn, color1_day, color2_dawn, color2_day)
