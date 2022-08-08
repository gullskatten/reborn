extends Sprite

const MIN_X_ROT = -42.1
const MAX_X_ROT = 41.91
var is_shifted := false

func _ready():
	get_material().set_shader_param("x_rot", MAX_X_ROT)
	animate_shadow()

func _physics_process(delta):
	pass

func animate_shadow():
	var TW = create_tween()
	TW.set_trans(Tween.EASE_IN)
	TW.set_ease(Tween.EASE_IN)
	TW.set_loops()
	TW.tween_property(
		get_material(),
		"shader_param/x_rot",
				MIN_X_ROT,
				3).from_current().as_relative()

	TW.set_parallel().tween_property(
		self, "modulate:a",
				0.0,
				3).from_current().as_relative()
				
	TW.chain().tween_interval(3)
