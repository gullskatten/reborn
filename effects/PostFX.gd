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
	InTime.connect("current_cycle_changed", self, "_set_color_fx")
	_set_color_fx(InTime.current_cycle)

func _transition_colors(color1_to, color1_from, color2_to, color2_from):
		$TweenColor1.interpolate_property(
					material,
					"shader_param/color1",
					color1_from,
					color1_to,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
		$TweenColor1.start()
		
		$TweenColor2.interpolate_property(
					material,
					"shader_param/color2",
					color2_from,
					color2_to,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
		$TweenColor2.start()

func _set_color_fx(cycle):
	if cycle == InTime.CycleState.DAWN:
		_transition_colors(color1_night, color1_dawn, color2_night, color2_dawn)
	elif cycle == InTime.CycleState.DUSK:
		_transition_colors(color1_day, color1_dusk, color2_day, color2_dusk)
	elif cycle == InTime.CycleState.NIGHT:
		_transition_colors(color1_dusk, color1_night, color2_dusk, color2_night)
	elif cycle == InTime.CycleState.DAY:
		_transition_colors(color1_dawn, color1_day, color2_dawn, color2_day)
