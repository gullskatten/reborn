extends KinematicBody2D

onready var shadow = $Shadow
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var footsteps = $Footsteps

var velocity : Vector2 = Vector2.ZERO
var state = MOVE

const ACCELERATION = 20
const MAX_SPEED = 80
const ROLL_SPEED = 120
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
	match state:
		MOVE:
			move_state()

func move_state():
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		footsteps.visible = true
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		
		if(animationState.get_current_node() == "Idle"):
			emit_signal("moving_started")
		animationState.travel("Run")
		if ((input_vector.x != 0 && input_vector.y == 0) || (input_vector.y != 0 && input_vector.x == 0)):
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
		if((input_vector.x > 0 && input_vector.y > 0) || (input_vector.x < 0 && input_vector.y < 0)):
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION).rotated(-0.254)
		elif((input_vector.x > 0 && input_vector.y < 0) || (input_vector.x < 0 && input_vector.y > 0)):
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION).rotated(0.254)
		
	else:
		if(animationState.get_current_node() == "Run"):
			emit_signal("moving_end")
		footsteps.visible = false
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)	
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	move()
	
func move():
	velocity = move_and_slide(velocity)

func _on_SoftCollision_body_entered(body):
	emit_signal("collision", body, $SoftCollision.global_position)
