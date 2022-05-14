extends ColorRect

onready var tween = $Tween


var transition_max := 1.602
var transition_min := 0.0
var current_transition := 0.0
const tick := 0.01

func _ready():
	GlobalCameraSettings.connect("loading_transition_end", self, "hide")
	GlobalCameraSettings.connect("loading_transition_start", self, "show")

func show():
	tween.interpolate_property(get_material(), 
						   "shader_param/time", 
						   transition_min, transition_max, 0.5, 
						   Tween.TRANS_LINEAR, Tween.EASE_OUT)

	tween.start()
	
func hide():
	tween.interpolate_property(get_material(), 
						   "shader_param/time", 
						   transition_max, transition_min, 0.5, 
						   Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
