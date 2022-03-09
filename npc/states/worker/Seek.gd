extends WorkerState

func enter(_msg := {}) -> void:
	worker.velocity = Vector2.ZERO
	print("Starting to seek next target..")


func update(delta: float) -> void:
	pass
