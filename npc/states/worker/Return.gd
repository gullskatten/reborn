extends WorkerState

var nearestCollectionPoint: Node = null  


func enter(_msg := {}) -> void:
	worker.set_collision_layer_bit(0, false)
	worker.set_collision_mask_bit(0, false)
	print("Finding nearest deposit..")
	
	var deposits = get_tree().get_nodes_in_group("resource_deposit")
	
	if deposits != null and not deposits.empty():
		print("Deposit was found!")
		# assume the first spawn node is closest
		nearestCollectionPoint = deposits[0]

	# look through spawn nodes to see if any are closer
		for deposit in deposits:
			if deposit.global_position.distance_to(worker.global_position) < nearestCollectionPoint.global_position.distance_to(worker.global_position):
				nearestCollectionPoint = deposit

	else:
		print("No deposits found!")
		state_machine.transition_to("Idle")

func update(delta: float) -> void:
	if nearestCollectionPoint != null:
		worker.accelerate_to_point(nearestCollectionPoint.global_position, delta)
