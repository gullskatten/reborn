extends Node2D

onready var animationPlayer = $AnimationPlayer

func _on_PlayerHintArea_body_entered(body):
	animationPlayer.play("OpenDoor")

func _on_PlayerHintArea_body_exited(body):
	animationPlayer.play("CloseDoor")
