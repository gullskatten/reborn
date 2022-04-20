extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var guardPos = $YSort/GuardsPosition
onready var cameraPosition = $CameraController/CameraPosition

var cameraFollowNode : RemoteTransform2D = RemoteTransform2D.new()

func _ready():
	CutSceneManager.connect("trigger", self, "start_animation")
	animationPlayer.connect("animation_finished", self, "animation_ended")
	cameraFollowNode.remote_path = cameraPosition.get_path()

func start_animation(triggerId: String):
	if animationPlayer.has_animation(triggerId):
		animationPlayer.play(triggerId)

func start_cutscene(name: String):
	GlobalCameraSettings.start_cutscene()
	GlobalCameraSettings.set_zoom_level(Vector2(0.1, 0.1))
	if name == "1.1":
		guardPos.add_child(cameraFollowNode) 
	
func end_cutscene(name: String):
	GlobalCameraSettings.end_cutscene()
	GlobalCameraSettings.set_zoom_level(GlobalCameraSettings.MIN_ZOOM)
	if name == "1.1":
		guardPos.remove_child(cameraFollowNode)

# After an animation has played, remove it from the scene
# It will however come back if we scene transition, so this is just a temp solution!
func animation_ended(name): 
	animationPlayer.remove_animation(name)
