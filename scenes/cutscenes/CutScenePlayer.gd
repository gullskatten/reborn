extends AnimationPlayer


func _ready():
	CutSceneManager.connect("trigger", self, "start_animation")

func start_animation(triggerId: String):
	if has_animation(triggerId):
		play(triggerId)

func start_cutscene(name: String):
	GlobalCameraSettings.start_cutscene()
	GlobalCameraSettings.set_zoom_level(GlobalCameraSettings.MIN_ZOOM)
	GlobalCameraSettings.is_locked = true

func _on_CutScene_animation_started(anim_name):
	GlobalCameraSettings.start_cutscene()
	GlobalCameraSettings.set_zoom_level(GlobalCameraSettings.MIN_ZOOM)
	GlobalCameraSettings.is_locked = true

# After an animation has played, remove it from the scene
# It will however come back if we scene transition, so this is just a temp solution!
func _on_CutScene_animation_finished(anim_name):
	GlobalCameraSettings.end_cutscene()
	GlobalCameraSettings.set_zoom_level(GlobalCameraSettings.MIN_ZOOM)
	GlobalCameraSettings.is_locked = false
	remove_animation(anim_name)
	
