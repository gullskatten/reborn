extends EnemyState

func enter(_msg := {}) -> void:
	enemy.animationState.travel("Move")
	enemy.chaseTimer.start()

func update(delta: float) -> void:
	var player = enemy.playerDetectionZone.player
	if player != null:
		enemy.accelerate_to_point(player.global_position, delta)
	else:
		state_machine.transition_to("Wander")
