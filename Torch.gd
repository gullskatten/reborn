extends Node2D

export(bool) var always_on := false

func _ready():
	if !always_on:
		InTime.connect("current_cycle_changed", self, "_set_light_enabled")
		_set_light_enabled(InTime.current_cycle)

func _set_light_enabled(cycle):
	var is_night = cycle == InTime.CycleState.NIGHT || cycle == InTime.CycleState.DUSK
	$AnimatedLight.enabled = is_night
	$Fire.emitting = is_night 
