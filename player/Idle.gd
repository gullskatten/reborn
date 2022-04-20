# Idle.gd
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animationState.travel("Idle")
	player.mount.animationState.travel("Idle")

func update(_delta: float) -> void:
	if player.allowed_movement && Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up"):
		player.emit_signal("moving_started")
		state_machine.transition_to("Run")
