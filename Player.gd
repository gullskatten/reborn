class_name Player
extends KinematicBody2D

onready var shadow = $Shadow
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var footsteps = $Footsteps

var velocity : Vector2 = Vector2.ZERO
var allowed_movement := true
var is_flipped := false

const ACCELERATION = 20
const RUN_MAX_SPEED = 90
const MOUNTED_MAX_SPEED = RUN_MAX_SPEED * 1.5
const RUN_ROTATION = -0.22587
const MOUNTED_ROTATION = RUN_ROTATION / 1.5

const FRICTION = 15
signal moving_started
signal moving_end
signal initial_position

func _ready():
	footsteps.visible = false
	randomize()
	animationTree.active = true
	emit_signal("initial_position", global_position)
	GlobalCameraSettings.connect("enable_movement", self, "enable_movement")
	GlobalCameraSettings.connect("disable_movement", self, "disable_movement")
	blink()

func enable_movement():
	allowed_movement = true

func disable_movement():
	allowed_movement = false

func _physics_process(delta):
	pass
	
func blink():
	var t = rand_range(1,8)
	yield(get_tree().create_timer(t/16),"timeout")
	$Eyes.visible = true
	$Timer.wait_time = t

func flip_h():
	if !is_flipped:
		transform.x *= -1
		is_flipped = true
		

func flip_reset():
	if is_flipped:
		transform.x *= -1
		is_flipped = false

func move():
	velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	$Eyes.visible = false
	blink()
