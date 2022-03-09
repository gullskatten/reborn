extends WorkerState

func enter(_msg := {}) -> void:
	worker.set_target_position(Vector2.ZERO)
	worker.velocity = Vector2.ZERO

func update(delta: float) -> void:
	pass
