extends CritterState

func enter(_msg := {}) -> void:
	critter.animationState.travel("Run")

func update(delta: float) -> void:
	if critter.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		critter.update_wander()
		
	critter.set_interest(critter.wanderController.target_position)
	critter.steer(delta, critter.MAX_SPEED)
	
	if critter.global_position.distance_to(critter.wanderController.target_position) <= critter.WANDER_TARGET_RANGE:
		state_machine.pick_random_state()
		critter.update_wander()	
