class_name SceneLocalTeleportPoint

extends Node2D

# Makes it so that you can call SceenTransitionManager.teleport("id")

export(String) var id := ""

func _ready():
	print(id + ": " + str(global_position))
	SceneTransitionManager.register_local_point(id, global_position)
	
func get_position() -> Vector2:
	return global_position
