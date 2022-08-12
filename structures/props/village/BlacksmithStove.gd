extends StaticBody2D




func _ready():
	InTime.connect("current_cycle_changed", self, "_set_light_enabled")
	_set_light_enabled(InTime.current_cycle)

func _set_light_enabled(cycle):
	$Light2D.enabled = cycle == InTime.CycleState.NIGHT

