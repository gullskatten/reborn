extends WorkerState

func enter(_msg := {}) -> void:
	worker.set_collision_layer_bit(0, true)
	worker.set_collision_mask_bit(0, true)
	worker.loadCapacity.reset_load()
	print("Delivering...")

func update(delta: float) -> void:
	pass
