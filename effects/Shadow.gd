extends Sprite

const MIN_X_ROT = -42.1
const MAX_X_ROT = 41.91
var is_shifted := false

func _ready():
	get_material().set_shader_param("x_rot", MAX_X_ROT)
	move_shadow()

func _physics_process(delta):
	pass

func move_shadow():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		get_material(),"shader_param/x_rot",
				MAX_X_ROT if is_shifted else MIN_X_ROT,
				Time.state_transition_duration).as_relative().set_trans(Tween.TRANS_LINEAR)
	is_shifted = !is_shifted	
	tween.connect("finished", self, "move_shadow")
