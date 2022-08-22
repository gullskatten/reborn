extends Node2D

const ZOOM_LOWER_LIMIT := 0.1
const ZOOM_UPPER_LIMIT := 1.0
const ZOOM_BASE_STEP := 0.1
const DEFAULT_OFFSET_X := 50
const DEFAULT_OFFSET_Y := 40

const still = Vector2(0, 0)

export var speed := 1000.0
export var zoom_speed := 10.0
export var smooth_zoom := 0.3 setget set_smooth_zoom
onready var cameraPosition = $CameraPosition
onready var camera = $CameraPosition/Camera

var motion = Vector2()

func _ready():
	GlobalCameraSettings.connect("forced_camera_position_changed", self, "_on_force_update_position")
	camera.zoom = Vector2.ONE * smooth_zoom
	
func set_smooth_zoom(value: float) -> void:
	smooth_zoom = clamp(value, ZOOM_LOWER_LIMIT, ZOOM_UPPER_LIMIT)

func _input(event):
	if event.is_action_pressed("action_zoom_in"):
		set_smooth_zoom(smooth_zoom - ZOOM_BASE_STEP * smooth_zoom / ZOOM_UPPER_LIMIT)
		
	elif event.is_action_pressed("action_zoom_out"):
		set_smooth_zoom(smooth_zoom + ZOOM_BASE_STEP * smooth_zoom / ZOOM_UPPER_LIMIT)
		
	if event is InputEventMouseMotion:
		motion = event.relative 
	
	if event is InputEventMouse:
		if event.is_action("action_left"):
			if event.is_pressed():
					GlobalCameraSettings.set_camera_position(cameraPosition.global_position)
				#print("action_left pressed: viewport_entered is ", viewport_entered)
					Input.action_press("pan_view")
			else:
				
				Input.action_release("pan_view")

func _physics_process(delta):
	var speed = 100 * delta
	
	if abs(camera.zoom.x - smooth_zoom) > 0.005:
		camera.zoom = lerp(camera.zoom, Vector2.ONE * smooth_zoom, delta * zoom_speed)
		camera.offset *= lerp(camera.zoom, Vector2.ONE * smooth_zoom, delta * zoom_speed) * 1.2
		
	if Input.is_action_pressed("pan_view"):
		if motion.abs() != still:
			cameraPosition.translate(-motion.round() * floor(speed))
			motion = still #Do not forget to reset your frame-time variables!		
	
func _on_force_update_position(position):
	if(cameraPosition != null):	
		cameraPosition.set_deferred("global_position", position)
