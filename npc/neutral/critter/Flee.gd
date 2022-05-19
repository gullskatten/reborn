extends CritterState

func enter(msg := {}) -> void:
	var mouseSqueels = ["Eeeeeek!", "Meep!", "Squeel!"]
	critter.animationState.travel("Run")
	critter.emoteLabel.visible = true
	mouseSqueels.shuffle()
	critter.emoteLabel.text = "* "+ mouseSqueels.pop_front() + " *"
	critter.flee_timer.start()
	
	
func update(delta: float) -> void:
	var player = critter.playerDetectionZone.player
	if player != null:
		critter.accelerate_away(player.global_position, delta)
	else:
		critter.wanderController.update_target_position()
		state_machine.transition_to("Wander")
