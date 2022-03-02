extends KinematicBody2D
onready var workerDialog = $WorkerDialog
onready var assignedLabel = $AssignedLabel
onready var sprite = $AnimatedSprite
enum {
	IDLE,
	WANDER,
	HUNT
}

var state = HUNT

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

export var CELESTIAL_NAME: String = "Little One"
onready var wanderController = $WanderController
onready var targetInfo: TargetInfo = $TargetButton/TargetInfo

var velocity = Vector2.ZERO


func _ready():
	randomize();
	state = pick_random_state([IDLE, WANDER])
	sprite.frame = rand_range(0, 4)
	targetInfo.display_name = CELESTIAL_NAME
	targetInfo.description = "Celestial"
	targetInfo.level = 1
	targetInfo.type = "Celestial"

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 	200 * delta)
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_to_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
			
		HUNT:
			pass
	velocity = move_and_slide(velocity)

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.set_wander_timer(rand_range(1,3))

func accelerate_to_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		workerDialog.visible = !workerDialog.visible
	  
func _on_Area2D_mouse_entered():
	print("Yo!!")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	workerDialog.visible = false

func _on_Control_collect_tree():
	workerDialog.visible = false
	assignedLabel.text = "Tree Worker"

func _on_WorkerDialog_collect_stone():
	workerDialog.visible = false
	assignedLabel.text = "Stone Worker"

func _on_WorkerDialog_collect_till():
	workerDialog.visible = false
	assignedLabel.text = "Tiller"

func _on_WorkerDialog_unassign():
	workerDialog.visible = false
	assignedLabel.text = "<Unassigned>"


func _on_TargetButton_pressed():
	CurrentTarget.set_target(targetInfo)
