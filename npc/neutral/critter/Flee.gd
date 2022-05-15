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
		critter.accelerate_away(player.global_position, delta)
	else:
		state_machine.transition_to("Wander")
