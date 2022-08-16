extends Node2D

export(bool) var always_on := false
export(bool) var disabled := false

func _ready():
	if !always_on && !disabled:
		InTime.connect("current_cycle_changed", self, "_set_light_enabled")
		_set_light_enabled(InTime.current_cycle)
		
func _set_light_enabled(cycle):
	if disabled: return
	var is_night = cycle == InTime.CycleState.NIGHT || cycle == InTime.CycleState.DUSK
	$Light2D.enabled = is_night

func set_disabled(is_disabled):
	disabled = is_disabled
