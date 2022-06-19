class_name Critter
extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 35
export var MAX_SPEED_FLEE = 70
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var nearest_home = null

onready var playerDetectionZone = $PlayerDetectionZone
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer
onready var state_machine = $States
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var softCollision = $SoftCollision
onready var emoteLabel = $EmoteLabel
onready var flee_timer = $FleeTimer

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
	if state_machine.state.name == "Flee":
		velocity = velocity.move_toward(direction * MAX_SPEED_FLEE, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	animationTree.set("parameters/Idle/blend_position", direction)
	animationTree.set("parameters/Run/blend_position", direction)

func accelerate_away(point, delta):
	if nearest_home != null:
		accelerate_to_point(nearest_home.global_position, delta)
	else:
		var direction = Vector2.ZERO
		
		if global_position.x > point.x:
			direction.x = 1
		else:
			direction.x = -1

		if global_position.y > point.y:
			direction.y = 1
		else:
			direction.y = -1

		velocity = velocity.move_toward(direction * MAX_SPEED_FLEE, ACCELERATION * delta)
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)

func update_wander():
	wanderController.set_wander_timer(rand_range(1,3))

func _on_HomeDetectionZone_area_entered(area):
	print(area)
	if area.is_in_group("mouse_home"):
		nearest_home = area

func _on_HomeDetectionZone_body_entered(body):
	if body.is_in_group("mouse_home"):
		nearest_home = body

func _on_PlayerDetectionZone_body_entered(_body):
	state_machine.transition_to("Flee")
