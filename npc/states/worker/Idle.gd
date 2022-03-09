# IDLE!
extends WorkerState

func enter(_msg := {}) -> void:
	worker.velocity = Vector2.ZERO


func update(delta: float) -> void:
	worker.velocity = worker.velocity.move_toward(Vector2.ZERO, 	200 * delta)
	
	if worker.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		worker.update_wander()
