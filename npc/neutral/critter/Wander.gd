extends CritterState

func enter(_msg := {}) -> void:
	critter.animationState.travel("Run")
	critter.emoteLabel.visible = false

func update(delta: float) -> void:
	critter.seek_player()
	if critter.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		critter.update_wander()
		
	critter.accelerate_to_point(critter.wanderController.target_position, delta)
	
	if critter.global_position.distance_to(critter.wanderController.target_position) <= critter.WANDER_TARGET_RANGE:
		state_machine.pick_random_state()
		critter.update_wander()	
