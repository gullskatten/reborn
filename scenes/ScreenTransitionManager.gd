extends Node

signal teleport(position)
signal request_move_node(id, node)

var registered_points : Dictionary = {}

func _ready():
	pass # Replace with function body.

func register_local_point(id: String, position: Vector2):
	registered_points[id] = position

func teleport_node_to(id: String, node):
	if registered_points.has(id):
		node.global_position = registered_points[id]
		emit_signal("request_move_node", id, node)

func teleport_player_to(id: String, playerNode):
	if registered_points.has(id):
		GlobalCameraSettings.start_loading_transition()
		GlobalCameraSettings.force_camera_position(registered_points[id])
		GlobalCameraSettings.end_loading_transition()
		playerNode.global_position = registered_points[id]
		emit_signal("request_move_node", id, playerNode)
