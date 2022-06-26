extends CritterState

func enter(_msg := {}) -> void:
	var mouseSqueels = ["Eeeeeek!", "Meep!", "Squeel!"]
	critter.animationState.travel("Run")
	critter.emoteLabel.visible = true
	mouseSqueels.shuffle()
	critter.emoteLabel.text = "* "+ mouseSqueels.pop_front() + " *"
	critter.flee_timer.start()
	
	
func update(delta: float) -> void:
	var player = critter.playerDetectionZone.player
	if player != null:
		if critter.nearest_home != null:
			critter.set_interest(critter.nearest_home.global_position)
		else:
			critter.set_interest(-player.global_position)
		critter.steer(delta, critter.MAX_SPEED_FLEE)
	else:
		critter.wanderController.update_target_position()
		state_machine.transition_to("Wander")
