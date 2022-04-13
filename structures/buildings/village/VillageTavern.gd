extends Node2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	pass # Replace with function body.

func _on_PlayerHintArea_body_entered(body):
	animationPlayer.play("OpenDoor")

func _on_PlayerHintArea_body_exited(body):
	animationPlayer.play("CloseDoor")
