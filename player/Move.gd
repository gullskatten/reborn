extends PlayerState

func enter(_msg := {}) -> void:
	if !player.allowed_movement:
		state_machine.transition_to("Idle")
	
func _physics_process(_delta: float) -> void:
	
	if !player.allowed_movement:
		state_machine.transition_to("Idle")
	
	else:
		var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

		if input_vector != Vector2.ZERO:
			player.animationState.travel("Run")
			var local_speed = player.RUN_MAX_SPEED
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
			player.velocity = player.velocity.move_toward(Vector2.ZERO, player.FRICTION)
			state_machine.transition_to("Idle")
		player.move()	
