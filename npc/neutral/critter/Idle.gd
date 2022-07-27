extends CritterState


func enter(_msg := {}) -> void:
	critter.velocity = Vector2.ZERO
	critter.animationState.travel("Idle")

func update(delta: float) -> void:
	critter.velocity = critter.velocity.move_toward(Vector2.ZERO, 	200 * delta)
	if critter.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		critter.update_wander()
