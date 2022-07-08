extends Node2D

export(bool) var always_on := false
onready var light_near = preload("res://assets/props/light/Light_Small_Scarce.png")
onready var light_far = preload("res://assets/props/light/Light_Tiny.png")
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
	GlobalCameraSettings.connect("zoom_level_changed", self, "_set_light")
	
	if !always_on:
		Time.connect("current_cycle_changed", self, "_set_light_enabled")
		_set_light_enabled(Time.current_cycle)
		
func _set_light(zoom_level):
	if GlobalCameraSettings.MAX_ZOOM - GlobalCameraSettings.ZOOM_FACTOR * 4 <= zoom_level:	
		$Light2D.texture = light_far
		$Light2D.texture_scale = 2.0
	else:
		$Light2D.texture_scale = 1.0
		$Light2D.texture = light_near
		$Light2D.energy = 1

func _set_light_enabled(cycle):
		$Light2D.enabled = cycle == Time.CycleState.NIGHT || cycle == Time.CycleState.DUSK
