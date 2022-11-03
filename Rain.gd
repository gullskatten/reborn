extends ColorRect

onready var far_rain = preload("res://assets/shaders/rain_far.png")
onready var close_rain = preload("res://assets/shaders/rain_close.png")

var should_show := false

func _ready():
	#GlobalCameraSettings.connect("zoom_level_changed", self, "zoom_changed")
	zoom_changed(GlobalCameraSettings.zoom_level)
	
func zoom_changed(zoom_level):
	if !should_show: return
	
	if GlobalCameraSettings.MAX_ZOOM - GlobalCameraSettings.ZOOM_FACTOR * 3 <= zoom_level:	
		hide()
	elif !visible:
		material.set_shader_param("intensity", 0.02)
		material.set_shader_param("noise", close_rain)
		show()


