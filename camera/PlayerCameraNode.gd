extends RemoteTransform2D

func _ready():
	pass # Replace with function body.

func _on_Player_moving_end():
	remote_path = NodePath("")

func _on_Player_moving_started():
	remote_path = NodePath("../../../../CameraController/CameraPosition/Camera")
