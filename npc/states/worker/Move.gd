extends WorkerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	pass

func update(delta: float) -> void:
	if worker.target_position != Vector2.ZERO:
		worker.accelerate_to_point(worker.target_position, delta)
		if worker.global_position.distance_to(worker.target_position) <= worker.WANDER_TARGET_RANGE:
			state_machine.pick_random_state()
			worker.update_wander()	
