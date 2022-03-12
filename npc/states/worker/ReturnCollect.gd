extends WorkerState

func enter(_msg := {}) -> void:
	print("Returning to last collection point..")

func update(delta: float) -> void:
	if worker.lastCollectionPoint != Vector2.ZERO:
		worker.accelerate_to_point(worker.lastCollectionPoint, delta)
		if worker.global_position.distance_to(worker.lastCollectionPoint) <= 5:
				state_machine.transition_to("Seek")
	else:
		state_machine.pick_random_state()
		worker.update_wander()
