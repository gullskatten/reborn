extends EnemyState

func enter(_msg := {}) -> void:
	enemy.animationState.travel("Move")


func update(delta: float) -> void:
	enemy.seek_player()
	if enemy.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		enemy.update_wander()
		
	enemy.accelerate_to_point(enemy.wanderController.target_position, delta)
	
	if enemy.global_position.distance_to(enemy.wanderController.target_position) <= enemy.WANDER_TARGET_RANGE:
		state_machine.pick_random_state()
		enemy.update_wander()	
