extends Node2D

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


