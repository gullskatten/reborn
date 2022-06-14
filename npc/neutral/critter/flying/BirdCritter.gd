extends KinematicBody2D
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var remote_transform : PathFollow2D = get_node("../Path2D/PathFollow2D")
export var speed = 90
var velocity = Vector2.ZERO

func _physics_process(delta):
	if remote_transform != null:
		remote_transform.set_offset(remote_transform.get_offset() + speed * delta)
		var direction = global_position.direction_to(remote_transform.get_global_position())
		animationTree.set("parameters/Land/blend_position", direction)
		animationTree.set("parameters/Fly/blend_position", direction)
	else:
		print("Remote transform not found!")
	
