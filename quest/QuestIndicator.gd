extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween().set_loops()
	#tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", 3.0, 0.6).as_relative().set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.6)
	tween.tween_property(self, "position:y", -3.0, 0.6).as_relative().set_trans(Tween.TRANS_ELASTIC)
	tween.tween_interval(0.6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
