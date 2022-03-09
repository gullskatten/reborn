# Idle.gd
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	player.velocity = Vector2.ZERO


func update(delta: float) -> void:
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up"):
		player.emit_signal("moving_started")
		player.animationState.travel("Run")
		state_machine.transition_to("Run")
