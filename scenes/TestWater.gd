extends Node


var scrHeight;
var calculatedOffset : float;

func _ready():
	scrHeight = ProjectSettings.get_setting("display/window/size/height");

func _process(delta):
	
	var camZoom = GlobalCameraSettings.zoom_level.y;
	
	calculatedOffset = (-GlobalCameraSettings.camera_position.y/(scrHeight) + self.position.y/scrHeight) * 2 / camZoom;
	
	self.material.set_shader_param("calculatedOffset", calculatedOffset);
