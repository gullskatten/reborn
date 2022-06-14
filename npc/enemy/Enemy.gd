class_name Enemy
extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

onready var state_machine = $States
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var sprite = $Sprite
onready var chaseTimer = $Timer
onready var targetInfo := $TargetButton/TargetInfo

var default = preload("res://assets/ui/cursors/cursor.png")
var onMouseHoverCursor = preload("res://assets/ui/cursors/cursor_attack.png")

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
		
	
func seek_player():
	if playerDetectionZone.can_see_player():
		state_machine.transition_to("Chase")

func accelerate_to_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	animationTree.set("parameters/Idle/blend_position", direction)
	animationTree.set("parameters/Move/blend_position", direction)
	animationTree.set("parameters/Attack/blend_position", direction)
	animationTree.set("parameters/Death/blend_position", direction)

func update_wander():
	wanderController.set_wander_timer(rand_range(1,3))


func _on_Timer_timeout():
	state_machine.transition_to("Idle")


func _on_TargetButton_mouse_entered():
	Input.set_custom_mouse_cursor(onMouseHoverCursor, 0, Vector2(0,0))


func _on_TargetButton_mouse_exited():
	Input.set_custom_mouse_cursor(default, 0, Vector2(0,0))


func _on_TargetButton_pressed():
	targetInfo.ref_node = self
	CurrentTarget.set_target(targetInfo)
