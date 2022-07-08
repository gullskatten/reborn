extends Node2D

var colliding_player = null

func _on_PlayerHintArea_body_entered(body):
	if body is Player:
		colliding_player = body
		Time.freeze_time = true
		GlobalCameraSettings.set_is_inside(true)

func _on_PlayerHintArea_body_exited(_body):
	colliding_player = null

func _on_PlayerEnterActionArea_action_pressed():
	if colliding_player != null:
		SceneTransitionManager.teleport_player_to("TavernEntrance", colliding_player)
		Time.freeze_time = false
		GlobalCameraSettings.set_is_inside(false)

func _on_NPCTeleport_body_entered(body):
	if body.is_in_group("teleportable"):
		SceneTransitionManager.teleport_node_to("TavernEntrance", body)
