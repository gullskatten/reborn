extends Node2D

onready var tween = $Tween
onready var hint = $ButtonPressHint

var should_hide := true

signal action_pressed

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") && hint.visible == true:
		should_hide = true
		hide_hint_button()
		emit_signal("action_pressed")

func _on_PlayerHintArea_body_entered(body):
	print("entered")
	should_hide = false
	GlobalCameraSettings.emit_signal("cutscene_start")
	GlobalCameraSettings.emit_signal("disable_movement")
	tween.interpolate_property(hint, "modulate",
		Color(2,2,2, 0), Color(1,1,1, 0.9), .1,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	hint.visible = true

func _on_PlayerHintArea_body_exited(body):
	should_hide = true
	GlobalCameraSettings.emit_signal("cutscene_end")
	GlobalCameraSettings.emit_signal("enable_movement")
	hide_hint_button()

func hide_hint_button():
	if hint.visible == true:
		print("Hide effect playing")
		tween.interpolate_property(hint, "modulate",
			Color(2,2,1, 0.9), Color(1,1,1, 0), .5,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		
		tween.start()


func _on_Tween_tween_all_completed():
	if should_hide:
		hint.visible = false
