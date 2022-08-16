extends Node2D

export(bool) var always_on := false
export(bool) var street_sign_NE := false 
export(bool) var street_sign_E := false 
export(bool) var street_sign_W := false 
export(bool) var street_sign_NW := false 
export(bool) var street_sign_SE := false 
export(bool) var street_sign_SW := false 


func _ready():
	$SignE.visible = street_sign_E
	$SignW.visible = street_sign_W
	$SignNW.visible = street_sign_NW
	$SignNE.visible = street_sign_NE
	$SignSW.visible = street_sign_SW
	$SignSE.visible = street_sign_SE
	
	if !always_on:
		InTime.connect("current_cycle_changed", self, "_set_light_enabled")
		_set_light_enabled(InTime.current_cycle)
	
func _set_light_enabled(cycle):
		$Light2D.enabled = cycle == InTime.CycleState.NIGHT || cycle == InTime.CycleState.DUSK
