extends ColorRect

onready var far_rain = preload("res://assets/shaders/rain_far.png")
onready var close_rain = preload("res://assets/shaders/rain_texture_close.png")

func _ready():
	set_visible(GlobalCameraSettings.zoom_level)
	GlobalCameraSettings.connect("zoom_level_changed", self, "set_visible")
	
func set_visible(zoom_level):
	if GlobalCameraSettings.MAX_ZOOM - GlobalCameraSettings.ZOOM_FACTOR * 3 <= zoom_level:	
		hide()
	elif !visible:
		material.set_shader_param("intensity", 0.01)
		material.set_shader_param("noise", close_rain)
		show()
	

