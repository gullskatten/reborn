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
onready var emoteLabel = $EmoteLabel
onready var flee_timer = $FleeTimer

export var steer_force = 0.2
export var look_ahead = 20
export var num_rays = 16

var inner_rotation = 0


# context array
var ray_directions = []
var interest = []
var danger = []

var chosen_dir = Vector2.ZERO
var acceleration = Vector2.ZERO

func _ready():
	wanderController.start_position = global_position
	animationTree.active = true
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle)
	
	set_default_interest()

func set_interest(point):
# Set interest in each slot based on world direction
	if point:
		var path_direction = global_position.direction_to(point)
		for i in num_rays:
			var d = ray_directions[i].rotated(inner_rotation).dot(path_direction)
			interest[i] = max(0, d)
	# If no world path, use default interest
	else:
		set_default_interest()

func set_default_interest():
 # Default to moving forward
	for i in num_rays:
		var d = ray_directions[i].rotated(inner_rotation).dot(transform.x)
		interest[i] = max(0, d)

func set_danger():
# Cast rays to find danger directions
	var space_state = get_world_2d().direct_space_state
	for i in num_rays:
		var result = space_state.intersect_ray(position,
				position + ray_directions[i].rotated(inner_rotation) * look_ahead,
				[self])
		danger[i] = 1.0 if result else 0.0
		
func choose_direction():
# Eliminate interest in slots with danger
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
# Choose direction based on remaining interest
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
	chosen_dir = chosen_dir.normalized()

func steer(delta, speed):
	set_danger()
	choose_direction()
	var desired_velocity = chosen_dir.rotated(inner_rotation) * speed
	velocity = velocity.linear_interpolate(desired_velocity, steer_force)
	inner_rotation = velocity.angle()
	animationTree.set("parameters/Idle/blend_position", velocity.normalized())
	animationTree.set("parameters/Run/blend_position", velocity.normalized())
	move_and_collide(velocity * delta)
	
	
func update_wander():
	wanderController.set_wander_timer(rand_range(1,3))

func _on_HomeDetectionZone_area_entered(area):
	if area.is_in_group("mouse_home"):
		nearest_home = area

func _on_HomeDetectionZone_body_entered(body):
	if body.is_in_group("mouse_home"):
		nearest_home = body

func _on_PlayerDetectionZone_body_entered(_body):
	state_machine.transition_to("Flee")
