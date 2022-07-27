extends CritterState

func enter(_msg := {}) -> void:
	critter.animationState.travel("Run")
	critter.flee_timer.start()
	
	
func update(delta: float) -> void:
	var player = critter.playerDetectionZone.player
	if player != null or critter.flee_timer.time_left > 0:
		if critter.nearest_home != null:
			critter.set_interest(critter.nearest_home.global_position)
		else:
			if player != null:
				critter.set_interest(-player.global_position)
			else: 
				critter.set_interest(null)
		critter.steer(delta, critter.MAX_SPEED_FLEE)
	else:
		critter.wanderController.update_target_position()
		state_machine.transition_to("Wander")
