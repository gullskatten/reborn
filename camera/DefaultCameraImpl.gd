extends Node2D


const ZOOM_LOWER_LIMIT := 0.1
const ZOOM_UPPER_LIMIT := 2.0
const ZOOM_BASE_STEP := 0.1
const still = Vector2(0, 0)

export var speed := 1000.0
export var zoom_speed := 10.0
export var smooth_zoom := 1.0 setget set_smooth_zoom
onready var camera = $CameraPos/DefaultCameraImpl
onready var camera_pos = $CameraPos

var motion = Vector2()

func _ready() -> void:
	#GlobalCameraSettings.connect("forced_camera_position_changed", self, "_on_force_update_position")
	camera.zoom = Vector2.ONE * smooth_zoom
	
func _process(delta: float) -> void:
	var speed = 100 * delta

	if abs(camera.zoom.x - smooth_zoom) > 0.005:
		camera.zoom = lerp(camera.zoom, Vector2.ONE * smooth_zoom, delta * zoom_speed)
	
	if Input.is_action_pressed("pan_view"):
		if motion.abs() != still:
			camera_pos.translate(-motion.round() * floor(speed))
			motion = still

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action_zoom_in"):
		set_smooth_zoom(smooth_zoom - ZOOM_BASE_STEP * smooth_zoom / ZOOM_UPPER_LIMIT)
	elif event.is_action_pressed("action_zoom_out"):
		set_smooth_zoom(smooth_zoom + ZOOM_BASE_STEP * smooth_zoom / ZOOM_UPPER_LIMIT)
	
	if event is InputEventMouseMotion:
		motion = event.relative 
	
	if event is InputEventMouse:
		if event.is_action("action_left"):
			if event.is_pressed():
					GlobalCameraSettings.set_camera_position(camera_pos.global_position)
					Input.action_press("pan_view")

			else:
				Input.action_release("pan_view")

func set_smooth_zoom(value: float) -> void:
	smooth_zoom = clamp(value, ZOOM_LOWER_LIMIT, ZOOM_UPPER_LIMIT)


