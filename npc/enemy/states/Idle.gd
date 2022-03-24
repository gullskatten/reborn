extends EnemyState


func enter(_msg := {}) -> void:
	enemy.velocity = Vector2.ZERO
	enemy.animationState.travel("Idle")


func update(delta: float) -> void:
	enemy.velocity = enemy.velocity.move_toward(Vector2.ZERO, 	200 * delta)
	enemy.seek_player()
	if enemy.wanderController.get_time_left() == 0:
		state_machine.pick_random_state()
		enemy.update_wander()
