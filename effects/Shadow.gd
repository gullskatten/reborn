extends Sprite

export(Vector3) var dawn = Vector3(8.0,0.0,1.0)
export(Vector3) var day = Vector3(-18.0,45.0,1.0)
export(Vector3) var dusk = Vector3(8.0,45.0,0.5)
export(Vector3) var night = Vector3(-24.0,-90.0,0.0)

func _ready():
	InTime.connect("current_cycle_changed", self, "_set_shadow_fx")
	_set_shadow_fx(InTime.current_cycle)

func _transition_shadow(x_to, rot_to, alpha_to, duration):
	var TW = create_tween()
	TW.set_trans(Tween.EASE_IN_OUT)
	TW.set_ease(Tween.EASE_IN_OUT)
	TW.set_parallel(true)
	TW.tween_property(
		get_material(),
		"shader_param/x_rot",
				x_to,
				duration).from_current()
	TW.tween_property(
		self,
		"rotation_degrees",
				rot_to,
				duration).from_current().as_relative()
	
	#var color = self.modulate
	TW.tween_property(
		self, "modulate:a",
				alpha_to,
				duration).from_current()
				
#	TW.chain()
	
func _set_shadow_fx(cycle):
	if cycle == InTime.CycleState.DAWN:
		_transition_shadow(dawn.x, dawn.y, dawn.z, InTime.state_transition_duration)
	elif cycle == InTime.CycleState.DUSK:
		_transition_shadow(dusk.x, dusk.y, dusk.z, InTime.state_transition_duration)
	elif cycle == InTime.CycleState.NIGHT:
		_transition_shadow(night.x, night.y, night.z, InTime.state_transition_duration / 2.0)
	elif cycle == InTime.CycleState.DAY:
		_transition_shadow(day.x, day.y, day.z, InTime.state_transition_duration)
