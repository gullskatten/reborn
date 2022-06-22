extends KinematicBody2D
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var timer = $Timer

onready var animationState = animationTree.get("parameters/playback")

export var speed = 140
var velocity = Vector2.ZERO
var ACCELERATION = 160
var FRICTION = 200
enum states {FLYING, IDLE, LANDING}
var currentState = states.IDLE
var destination = null
var landing_spots = []

func _ready():
	randomize()
	animationState.start("Idle")
	timer.wait_time = rand_range(2.0, 20.0)
	timer.start()
	landing_spots = get_tree().get_nodes_in_group("bird_rest_location")
	
	
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
			velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
			rotation = velocity.angle() * -0.1 if velocity.angle() < 0 else velocity.angle() * 0.1
			move_and_slide(velocity)
		
	elif currentState == states.LANDING:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		
		if velocity.is_equal_approx(Vector2.ZERO):
			destination = null
			timer.wait_time = 16.0
			currentState = states.IDLE
		
func seek_landing():
	if currentState == states.FLYING:
		if !landing_spots.empty():
			landing_spots.shuffle()
			destination = landing_spots.pop_front()
			
	elif currentState == states.IDLE:
		var idle_states = ["Peck", "Pluck", "Idle", "Takeoff"]
		idle_states.shuffle()
		var next_state = idle_states.pop_front()
		
		if next_state == "Takeoff":
			currentState = states.FLYING
			seek_landing()
		animationState.travel(next_state)

func on_take_off_end():
	print("Flying called")
	animationState.travel("Fly")
	
func _on_Timer_timeout():
	seek_landing()


func _on_PlayerDetectionZone_body_entered(body):
	if currentState != states.FLYING:
		currentState = states.FLYING
		seek_landing()
		animationState.travel("Takeoff")
