extends Node2D

const ZOOM_LOWER_LIMIT := 0.1
const ZOOM_UPPER_LIMIT := 1.0
const ZOOM_BASE_STEP := 0.1

export var speed := 1000.0
export var zoom_speed := 10.0
export var smooth_zoom := 0.3 setget set_smooth_zoom
onready var cameraPosition = $CameraPosition
onready var camera = $CameraPosition/Camera

var motion = Vector2()

func _ready():
	GlobalCameraSettings.connect("forced_camera_position_changed", self, "_on_force_update_position")
	GlobalCameraSettings.connect("forced_zoom_changed", self, "_on_force_update_zoom")
	camera.zoom = Vector2.ONE * smooth_zoom
	
func set_smooth_zoom(value: float) -> void:
	smooth_zoom = clamp(value, ZOOM_LOWER_LIMIT, ZOOM_UPPER_LIMIT)
	#camera.offset = Vector2(-value * 1400, -value  * 1200)
	
func _input(event):
	if GlobalCameraSettings.is_locked:
		return
		
	if event.is_action_pressed("action_zoom_in"):
		set_smooth_zoom(smooth_zoom - ZOOM_BASE_STEP * smooth_zoom / ZOOM_UPPER_LIMIT)
		
	elif event.is_action_pressed("action_zoom_out"):
		set_smooth_zoom(smooth_zoom + ZOOM_BASE_STEP * smooth_zoom / ZOOM_UPPER_LIMIT)
		
func _physics_process(delta):
	var speed = 100 * delta
	
	if abs(camera.zoom.x - smooth_zoom) > 0.005:
		camera.zoom = lerp(camera.zoom, Vector2.ONE * smooth_zoom, delta * zoom_speed)
	
func _on_force_update_position(position):
	if(cameraPosition != null):	
		cameraPosition.set_deferred("global_position", position)

func _on_force_update_zoom(zoom):
	if(cameraPosition != null):	
		cameraPosition.set_deferred("global_position", position)
