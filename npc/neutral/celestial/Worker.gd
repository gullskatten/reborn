class_name Worker
extends KinematicBody2D
onready var sprite = $AnimatedSprite
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

var target_position = null setget set_target_position  # Set this to move.
var selected = false setget set_selected  # Is this unit selected?
var assigned_resource_type : String = "" setget set_assigned_resource_type
var connected_resource : ResourceStats = null
var resource_exhaust_connection = null
var resource_exiting_connection = null
export var CELESTIAL_NAME: String = "Little One"
onready var wanderController = $WanderController
onready var targetButton := $TargetButton
onready var targetInfo := $TargetButton/TargetInfo
onready var stateMachine := $States
onready var loadCapacity := $WorkerLoadCapacity
onready var loadOutTimer: Timer = $LoadOutTimer
onready var seekTimer: Timer = $SeekTimer
onready var resourceDetectionZone : Area2D = $ResourceDetectionZone

var velocity = Vector2.ZERO
var lastCollectionPoint = Vector2.ZERO
var isAssignedWork = false

func _ready():
	randomize();
	sprite.frame = rand_range(0, 4)
	targetInfo.display_name = CELESTIAL_NAME
	targetInfo.description = "Celestial Worker"
	targetInfo.level = 1
	targetInfo.type = "Worker"
	targetInfo.ref_node = self
	CurrentTarget.connect("cancel_target", self, "remove_selection")

func _physics_process(delta):
	velocity = move_and_slide(velocity)

func remove_selection():
	set_selected(false)

func update_wander():
	target_position = null
	wanderController.start_position = global_position
	wanderController.set_wander_timer(rand_range(1,3))

func accelerate_to_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func _on_TargetButton_pressed():
	CurrentTarget.cancel_targets()
	CurrentTarget.set_target(targetInfo)
	set_selected(true)	

func set_target_position(target: Vector2):
	target_position = target
	
	if target != Vector2.ZERO:
		wanderController.target_position = target
		wanderController.start_position = target
		stateMachine.transition_to("Move")

func set_assigned_resource_type(resource_type):
	print("Assigned worker:")
	print(resource_type)
	assigned_resource_type = resource_type

func set_selected(val: bool):
	if val:
		get_node("AnimatedSprite").material.set_shader_param("is_active", true)
	else:
		get_node("AnimatedSprite").material.set_shader_param("is_active", false)


func _on_WorkerResourceHitbox_area_entered(area):
	if !loadCapacity.is_full():
		if area.get_parent() is CollectableResource:
			var resource : CollectableResource = area.get_parent()
			var resourceStats : ResourceStats = resource.stats
			if resource_exhaust_connection == null:
				resource_exhaust_connection = resourceStats.connect("no_resource_left", self, "on_resource_exhaust")
				resource_exiting_connection = resourceStats.connect("tree_exiting", self, "on_resource_exhaust")
			connected_resource = resourceStats
		stateMachine.transition_to("Collect")
		loadCapacity.start_loading()

func on_resource_exhaust():
	connected_resource = null
	resource_exhaust_connection = null
	resource_exiting_connection = null
	if not loadCapacity.is_full():
		stateMachine.transition_to("Seek")
	loadCapacity.stop_loading()

func _on_WorkerLoadCapacity_is_full(val):
	stateMachine.transition_to("Return")

func _on_WorkerLoadCapacity_load_changed(val, increment):
	if connected_resource != null:
		connected_resource.call_deferred("decrease_resource", increment)


func _on_WorkerResourceDeliveryHitbox_area_entered(area):
	if loadCapacity.currentLoad > 0:
		loadOutTimer.start()
		stateMachine.transition_to("Deliver")

func _on_LoadOutTimer_timeout():
	stateMachine.transition_to("ReturnCollect")


func _on_SeekTimer_timeout():
	print("Seek timed out!")	
	if stateMachine.state.name == "Seek":
		if loadCapacity.currentLoad > 0:
			stateMachine.transition_to("Return")
		else:
			print("Seek was current state, starting to wander..")	
			stateMachine.pick_random_state()
			update_wander()
