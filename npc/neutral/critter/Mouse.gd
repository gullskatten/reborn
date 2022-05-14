class_name Critter
extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4


var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var playerDetectionZone = $PlayerDetectionZone
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var state_machine = $States
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var softCollision = $SoftCollision

func _ready():
	wanderController.start_position = global_position
	animationTree.active = true

	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
		
	if(velocity != Vector2.ZERO):	
		velocity = move_and_slide(velocity)


func accelerate_to_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	animationTree.set("parameters/Idle/blend_position", direction)
	animationTree.set("parameters/Run/blend_position", direction)
	
func seek_player():
	if playerDetectionZone.can_see_player():
		state_machine.transition_to("Run")

func update_wander():
	wanderController.set_wander_timer(rand_range(1,3))

