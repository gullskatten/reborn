extends Node2D

export(bool) var always_on := false

func _ready():
	if !always_on:
		Time.connect("current_cycle_changed", self, "_set_light_enabled")
		_set_light_enabled(Time.current_cycle)

func _set_light_enabled(cycle):
	var is_night = cycle == Time.CycleState.NIGHT || cycle == Time.CycleState.DUSK
	$AnimatedLight.enabled = is_night
	$Fire.emitting = is_night 
