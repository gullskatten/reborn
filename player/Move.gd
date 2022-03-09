extends PlayerState

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	var local_speed = player.RUN_MAX_SPEED
	
	if input_vector != Vector2.ZERO:
		var local_rotation = player.RUN_ROTATION
		player.footsteps.visible = true
		player.animationTree.set("parameters/Idle/blend_position", input_vector)
		player.animationTree.set("parameters/Run/blend_position", input_vector)
		
		if ((input_vector.x != 0 && input_vector.y == 0) || (input_vector.y != 0 && input_vector.x == 0)):
			player.velocity = player.velocity.move_toward(input_vector * local_speed, player.ACCELERATION)
		if((input_vector.x > 0 && input_vector.y > 0) || (input_vector.x < 0 && input_vector.y < 0)):
			player.velocity = player.velocity.move_toward(input_vector * local_speed, player.ACCELERATION).rotated(local_rotation)
		elif((input_vector.x > 0 && input_vector.y < 0) || (input_vector.x < 0 && input_vector.y > 0)):
			player.velocity = player.velocity.move_toward(input_vector * local_speed, player.ACCELERATION).rotated(local_rotation * -1)
		
	else:
		if(player.animationState.get_current_node() == "Run"):
			player.emit_signal("moving_end")
		player.footsteps.visible = false
		player.velocity = player.velocity.move_toward(input_vector * local_speed, player.ACCELERATION)	
		player.animationState.travel("Idle")
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.FRICTION)
		state_machine.transition_to("Idle")
	player.move()
