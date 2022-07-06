extends Node2D

onready var tween = $Tween
onready var hint = $ButtonPressHint
onready var hintLabel = $ButtonPressHint/PanelContainer/CenterContainer/Label

export(bool) var is_scene_trigger := false
export(bool) var is_single_trigger := true
export(Array, String) var scene_triggers := []

var should_hide := true
var is_active := true

signal action_pressed

func on_retry():
	is_active = true
	hint.visible = true
	

func _physics_process(delta):
	if is_active && Input.is_action_just_pressed("ui_accept") && hint.visible == true:
		should_hide = true
		if is_single_trigger:
			is_active = false
			
		hide_hint_button()
		emit_signal("action_pressed")

func _on_PlayerHintArea_body_entered(body):
	if is_scene_trigger:
		for trigger in scene_triggers:
			CutSceneManager.attemptTrigger(trigger)
	
	should_hide = false
	tween.interpolate_property(hint, "modulate",
	Color(2,2,2, 0), Color(1,1,1, 0.9), .1,
	Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	hint.visible = true

func _on_PlayerHintArea_body_exited(body):
	should_hide = true
	hide_hint_button()

func hide_hint_button():
	if hint.visible == true:
		if tween.is_inside_tree():
			tween.interpolate_property(hint, "modulate",
			Color(2,2,1, 0.9), Color(1,1,1, 0), .5,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		
			tween.start()

func _on_Tween_tween_all_completed():
	if should_hide:
		hint.visible = false
