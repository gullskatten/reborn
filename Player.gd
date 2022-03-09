class_name Player
extends KinematicBody2D

onready var shadow = $Shadow
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var footsteps = $Footsteps

var velocity : Vector2 = Vector2.ZERO
var state = MOVE
var is_mounted = true

const ACCELERATION = 20
const RUN_MAX_SPEED = 80
const MOUNTED_MAX_SPEED = RUN_MAX_SPEED * 1.5
const RUN_ROTATION = -0.258
const MOUNTED_ROTATION = RUN_ROTATION / 1.5

const FRICTION = 15
signal moving_started
signal moving_end
signal initial_position
signal collision

enum {
	MOVE,
}

func _ready():
	footsteps.visible = false
	randomize()
	animationTree.active = true
	emit_signal("initial_position", global_position)
	
func _physics_process(delta):
	pass

func move():
	velocity = move_and_slide(velocity)

func _on_SoftCollision_body_entered(body):
	emit_signal("collision", body, $SoftCollision.global_position)
