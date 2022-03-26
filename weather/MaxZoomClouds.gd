extends Control

const Fog = preload("res://weather/Fog.tscn")

var inst := Fog.instance()

func _ready():
	self.visible = true
	GlobalCameraSettings.connect("max_zoom_level_changed", self, "setVisible")

func setVisible(is_max):
	if(is_max):
		inst = Fog.instance()
		add_child(inst)
		var tween = get_node("Tween")
		tween.interpolate_property(inst, "modulate",
		Color(1,1,1,0), Color(1,1,1,1), 0.45,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
	else:
		var tween = get_node("Tween")
		tween.interpolate_property(inst, "modulate",
		Color(1,1,1,1), Color(1,1,1,0), 0.45,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		tween.connect("tween_all_completed", inst, "queue_free")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
