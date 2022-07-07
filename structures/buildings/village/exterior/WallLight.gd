extends Node2D

export(bool) var always_on := false

func _ready():
	if !always_on:
		Time.connect("current_cycle_changed", self, "_set_light_enabled")

func _set_light_enabled(cycle):
	var is_night = cycle == Time.CycleState.NIGHT || cycle == Time.CycleState.DUSK
	$Light2D.enabled = is_night
