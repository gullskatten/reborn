extends Control

onready var tween = $Tween
export var message_color: Color = Color.salmon
const SmallLabel = preload("res://ui/SmallLabel.tscn")

func _ready():
	Logger.connect("on_error", self, "err")

func err(message):
	if !tween.is_active():
		var label = SmallLabel.instance()
		label.text = str(message)
		label.visible = true
		label.add_color_override("font_color", message_color)
		label.modulate = Color(0,0,0,0)
		add_child(label)
		
		tween.interpolate_property(label, "modulate",
			Color(message_color.r,message_color.g,message_color.b, 1), Color(message_color.r,message_color.g,message_color.b, 0), 1.0,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.interpolate_property(label, "rect_position",
			Vector2(0, floor(rand_range(10, 20))), Vector2(0, -10), 1.2,
			Tween.TRANS_LINEAR, 0)
		tween.start()
		
		tween.connect("tween_all_completed", label, "queue_free")
