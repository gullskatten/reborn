# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name CritterState
extends State

var critter: Critter

func _ready() -> void:
	# The states are children of the `Enemy` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	yield(owner, "ready")
	# The `as` keyword casts the `owner` variable to the `Enemy` type.
	# If the `owner` is not a `Enemy`, we'll get `null`.
	critter = owner as Critter
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Enemy.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(critter != null)
