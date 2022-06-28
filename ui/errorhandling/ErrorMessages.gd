extends Control

export var message_color: Color = Color.salmon
export var isTargetable: bool = true
const IncreaseLabel = preload("res://ui/SmallLabel.tscn")

func print(message):
	var increaseLabel = IncreaseLabel.instance()
	increaseLabel.text = str(message)
	increaseLabel.visible = true
	increaseLabel.add_color_override("font_color", message_color)
	increaseLabel.modulate = Color(0,0,0,0)
	add_child(increaseLabel)
	var tween = get_node("Tween")
	tween.interpolate_property(increaseLabel, "modulate",
		Color(message_color.r,message_color.g,message_color.b, 1), Color(message_color.r,message_color.g,message_color.b, 0), 1.0,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(increaseLabel, "rect_position",
		Vector2(0, floor(rand_range(10, 20))), Vector2(floor(rand_range(-10, 10)), 0), 1.2,
		Tween.TRANS_LINEAR, 0)
	tween.start()
	
	tween.connect("tween_all_completed", increaseLabel, "queue_free")
