extends Control

onready var top = $Top
onready var bottom = $Bottom
onready var tween = $Tween

var should_hide = false

func _ready():
	GlobalCameraSettings.connect("enable_movement", self, "hide")
	GlobalCameraSettings.connect("disable_movement", self, "show")
	top.visible = false
	bottom.visible = false
	

func show():
	print("Showing!")
	should_hide = false
	top.visible = true
	bottom.visible = true
	tween.interpolate_property(top, "rect_position",
		top.rect_global_position+Vector2(0, 80), top.rect_global_position, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	tween.interpolate_property(bottom, "rect_position",
		bottom.rect_global_position-Vector2(0, -80), bottom.rect_global_position, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
	
func hide():
	print("Removing!")
	should_hide = true
	top.visible = true
	bottom.visible = true
	tween.interpolate_property(top, "rect_position",
		top.rect_global_position, top.rect_global_position-Vector2(0, 80), 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	tween.interpolate_property(bottom, "rect_position",
		bottom.rect_global_position, bottom.rect_global_position-Vector2(0, -80), 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_all_completed():
	if should_hide:
		bottom.visible = false
		top.visible = false
