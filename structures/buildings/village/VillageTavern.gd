extends Node2D

onready var animationPlayer = $AnimationPlayer

var colliding_player = null

func _on_PlayerHintArea_body_entered(body):
	animationPlayer.play("OpenDoor")
	
	if body is Player:
		colliding_player = body
	elif body.is_in_group("teleportable"):
		SceneTransitionManager.teleport_node_to("TavernGroundFloor", body)
		
func _on_PlayerHintArea_body_exited(body):
	animationPlayer.play("CloseDoor")
	colliding_player = null

func _on_PlayerEnterActionArea_action_pressed():
	if colliding_player != null:
		print("Teleporting player to TavernInside")
		SceneTransitionManager.teleport_player_to("TavernGroundFloor", colliding_player)
