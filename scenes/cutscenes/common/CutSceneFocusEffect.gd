extends Control

onready var top = $Top
onready var bottom = $Bottom
onready var tween = $Tween

var should_hide = false
var positions : Dictionary = {}

func _ready():
	GlobalCameraSettings.connect("cutscene_end", self, "hide")
	GlobalCameraSettings.connect("cutscene_start", self, "show")
	top.visible = false
	bottom.visible = false
	
	positions['top'] = top.rect_global_position-Vector2(0, 100)
	positions['bottom'] = bottom.rect_global_position-Vector2(0, -100)
	
	positions['top_vis'] = top.rect_global_position
	positions['bottom_vis'] = bottom.rect_global_position
	

func show():
	should_hide = false
	top.visible = true
	bottom.visible = true
	tween.interpolate_property(top, "rect_position",
		positions['top'], positions['top_vis'], 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	tween.interpolate_property(bottom, "rect_position",
		positions['bottom'], positions['bottom_vis'] , 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
	
func hide():
	should_hide = true
	top.visible = true
	bottom.visible = true
	tween.interpolate_property(top, "rect_position",
		positions['top_vis'], positions['top'], 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	tween.interpolate_property(bottom, "rect_position",
		positions['bottom_vis'] , positions['bottom'] , 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_all_completed():
	if should_hide:
		bottom.visible = false
		top.visible = false
