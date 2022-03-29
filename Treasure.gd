extends Node2D

onready var tween = $Tween
onready var hint = $ButtonPressHint

func _ready():
	pass

func _on_PlayerHintArea_body_entered(body):
	tween.interpolate_property(hint, "modulate",
		Color(2,2,2, 0), Color(1,1,1, 0.9), .1,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	hint.visible = true

func _on_PlayerHintArea_body_exited(body):
	tween.interpolate_property(hint, "modulate",
			Color(2,2,1, 0.9), Color(1,1,1, 0), .5,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		
	tween.start()
