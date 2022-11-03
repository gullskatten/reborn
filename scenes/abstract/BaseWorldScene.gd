extends Node2D

onready var cameraPosition = $CameraController/CameraPosition

var cameraFollowNode : RemoteTransform2D = RemoteTransform2D.new()

func _ready():
	SceneTransitionManager.connect("request_move_node", self, "move_node_to_teleport_point")
	cameraFollowNode.remote_path = cameraPosition.get_path()

func move_node_to_teleport_point(id, node):
	for point in get_tree().get_nodes_in_group("teleportation_point"):
		if point is SceneLocalTeleportPoint and point.id == id:
			var new_node = load(node.filename).instance()
			node.queue_free()
			new_node.position = point.position
			point.get_parent().add_child(new_node)
