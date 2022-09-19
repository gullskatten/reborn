extends StaticBody2D

onready var animationPlayer = $AnimationPlayer

func _on_PlayerHintArea_body_entered(_body):
	animationPlayer.play("wake_up")


func _on_PlayerHintArea_body_exited(_body):
	animationPlayer.play("sleep")
