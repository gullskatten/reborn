extends KinematicBody2D
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var timer = $Timer

onready var animationState = animationTree.get("parameters/playback")
onready var remote_transform : PathFollow2D = get_node("../Path2D/PathFollow2D")

export var speed = 90
var velocity = Vector2.ZERO
var ACCELERATION = 100
var FRICTION = 200
enum states {FLYING, IDLE, LANDING}
var currentState = states.FLYING
var destination = null

func _ready():
	randomize()
	animationState.travel("Fly")
	

func _physics_process(delta):
	if currentState == states.FLYING:
		if destination != null: 
			var direction = global_position.direction_to(destination.get_global_position())
			animationTree.set("parameters/Fly/blend_position", direction)
			
			if global_position.distance_to(destination.get_global_position()) < 5.0:
				animationTree.set("parameters/Land/blend_position", direction)
				animationTree.set("parameters/Idle/blend_position", direction)
				animationTree.set("parameters/Takeoff/blend_position", direction)
				animationTree.set("parameters/Peck/blend_position", direction)
				animationTree.set("parameters/Pluck/blend_position", direction)
				currentState = states.LANDING
				animationState.travel("Land")
				print("Landing...")
			
			velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
			move_and_slide(velocity)
		elif remote_transform != null:
			remote_transform.set_offset(remote_transform.get_offset() + speed * delta)
			var direction = global_position.direction_to(remote_transform.get_global_position())
			animationTree.set("parameters/Fly/blend_position", direction)
	
	elif currentState == states.LANDING:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		
		if velocity.is_equal_approx(Vector2.ZERO):
			destination = null
			timer.wait_time = 5.0
			currentState = states.IDLE
		
func seek_landing():
	if currentState == states.FLYING:
		var landing_spots = get_tree().get_nodes_in_group("bird_rest_location")
		if !landing_spots.empty():
			print("Found spot to land!")
			landing_spots.shuffle()
			destination = landing_spots.pop_front()
			
	elif currentState == states.IDLE:
		print("I'm idle..")
		var idle_states = ["Peck", "Pluck", "Idle", "Fly"]
		idle_states.shuffle()
		var next_state = idle_states.pop_front()
		
		if next_state == "Fly":
			print("Starting flying")
			timer.wait_time = 20
			currentState = states.FLYING
		animationState.travel(next_state)
		
func _on_Timer_timeout():
	seek_landing()
