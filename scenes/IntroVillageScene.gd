extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var guardPos = $OutsideYSort/GuardsPosition
onready var cameraPosition = $CameraController/CameraPosition
onready var deepWaterCollision = $Water/DeepWater

var cameraFollowNode : RemoteTransform2D = RemoteTransform2D.new()
		

	
func _ready():
	for dock in get_tree().get_nodes_in_group("Dock"):
		dock.connect("deep_water_collision_off", self, "deep_water_collision_off")
		dock.connect("deep_water_collision_on", self, "deep_water_collision_on")
	$AudioStreamPlayer.play()
	CutSceneManager.connect("trigger", self, "start_animation")
	animationPlayer.connect("animation_finished", self, "animation_ended")
	SceneTransitionManager.connect("request_move_node", self, "move_node_to_teleport_point")
	cameraFollowNode.remote_path = cameraPosition.get_path()
	
func deep_water_collision_off():
	deepWaterCollision.set_collision_layer_bit(0, false)
	deepWaterCollision.set_collision_mask_bit(0, false)
	
func deep_water_collision_on():
	deepWaterCollision.set_collision_layer_bit(0, true)
	deepWaterCollision.set_collision_mask_bit(0, true)

func start_animation(triggerId: String):
	if animationPlayer.has_animation(triggerId):
		animationPlayer.play(triggerId)

func start_cutscene(name: String):
	GlobalCameraSettings.start_cutscene()
	GlobalCameraSettings.set_zoom_level(Vector2(0.1, 0.1))
	GlobalCameraSettings.is_locked = true
	
	if name == "1.1":
		guardPos.add_child(cameraFollowNode) 
	
func end_cutscene(name: String):
	GlobalCameraSettings.end_cutscene()
	GlobalCameraSettings.set_zoom_level(GlobalCameraSettings.MIN_ZOOM)
	GlobalCameraSettings.is_locked = false
	
	if name == "1.1":
		guardPos.remove_child(cameraFollowNode)

# After an animation has played, remove it from the scene
# It will however come back if we scene transition, so this is just a temp solution!
func animation_ended(name): 
	animationPlayer.remove_animation(name)
	
func move_node_to_teleport_point(id, node):
	for point in get_tree().get_nodes_in_group("teleportation_point"):
		if point is SceneLocalTeleportPoint and point.id == id:
			var new_node = load(node.filename).instance()
			node.queue_free()
			new_node.position = point.position
			point.get_parent().add_child(new_node)
