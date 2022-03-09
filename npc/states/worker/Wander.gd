extends WorkerState

func enter(_msg := {}) -> void:
	pass


func update(delta: float) -> void:
	
	if worker.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		worker.update_wander()
				
	worker.accelerate_to_point(worker.wanderController.target_position, delta)
	
	if worker.global_position.distance_to(worker.wanderController.target_position) <= worker.WANDER_TARGET_RANGE:
		state_machine.pick_random_state()
		worker.update_wander()	
