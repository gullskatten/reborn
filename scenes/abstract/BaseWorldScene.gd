extends Node2D

onready var cameraPosition = $CameraController/CameraPosition
onready var player = $InnerScenes/PlayerTemplate

var cameraFollowNode : RemoteTransform2D = RemoteTransform2D.new()
var still = Vector2.ZERO

var motion = Vector2()

func _ready():
	SceneTransitionManager.connect("request_move_node", self, "move_node_to_teleport_point")
	cameraFollowNode.remote_path = cameraPosition.get_path()
	player.add_child(cameraFollowNode)


func _input(event):
	if GlobalCameraSettings.is_locked:
		return

	elif event is InputEventMouseMotion:
		motion = event.relative 

	elif event is InputEventMouse:
		if event.is_action("action_left"):
			if event.is_pressed():
					if player.is_a_parent_of(cameraFollowNode):
						player.remove_child(cameraFollowNode)
						cameraFollowNode.global_position = player.global_position
						add_child(cameraFollowNode)
					
					Input.action_press("pan_view")
			else:
				Input.action_release("pan_view")
				if is_a_parent_of(cameraFollowNode):
					remove_child(cameraFollowNode)
					player.add_child(cameraFollowNode)

func _physics_process(delta):
	if Input.is_action_pressed("pan_view"):
		if motion.abs() != still:
			var speed = 100 * delta
			print(cameraFollowNode.global_position)
			cameraFollowNode.translate(-motion.round() * floor(speed))
			motion = still #Do not forget to reset your frame-time variables!	
	else:
		cameraFollowNode.global_position = player.global_position
	
func move_node_to_teleport_point(id, node):
	for point in get_tree().get_nodes_in_group("teleportation_point"):
		if point is SceneLocalTeleportPoint and point.id == id:
			var new_node = load(node.filename).instance()
			node.queue_free()
			new_node.position = point.position
			point.get_parent().add_child(new_node)
