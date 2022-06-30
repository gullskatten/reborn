class_name Player
extends KinematicBody2D

onready var shadow = $Shadow
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var footsteps = $Footsteps
onready var mount = $Mount

var select_rect = RectangleShape2D.new()

var velocity : Vector2 = Vector2.ZERO
var allowed_movement := true
const ACCELERATION = 20
const RUN_MAX_SPEED = 80
const MOUNTED_MAX_SPEED = RUN_MAX_SPEED * 1.5
const RUN_ROTATION = -0.258
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
	SceneTransitionManager.connect("teleport", self, "teleport")
	blink()
	
func teleport(position: Vector2):
	global_position = position

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
	
func move():
	velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	$Eyes.visible = false
	blink()
