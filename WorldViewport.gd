extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalCameraSettings.connect("world_input_disabled_changed", self, "set_disable_gui_input")
	
func set_disable_gui_input(is_disabled):
	gui_disable_input = is_disabled


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
