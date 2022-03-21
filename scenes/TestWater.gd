extends Node


var scrHeight;
var calculatedOffset : float;

func _ready():
	scrHeight = ProjectSettings.get_setting("display/window/size/height");

func _process(delta):
