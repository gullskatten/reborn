extends Node2D
onready var cameraPosition = $CameraPosition
onready var camera = $CameraPosition/Camera

var motion = Vector2()
const still = Vector2(0, 0)


func _ready():
	GlobalCameraSettings.connect("zoom_level_changed", self, "set_camera_zoom")
	GlobalCameraSettings.connect("forced_camera_position_changed", self, "_on_force_update_position")
	
func set_camera_zoom(zoom):
	
	if zoom == GlobalCameraSettings.MIN_ZOOM:
		camera.offset = Vector2(-20, -40)
	else:
		camera.offset = Vector2(-10, -10)
	if(!is_zero_approx(zoom.x) && !is_zero_approx(zoom.y)):
		camera.zoom = zoom

func _input(event):
	if event is InputEventMouseMotion:
		motion = event.relative 
	
	if event is InputEventMouse:
		if event.is_action("action_left"):
			if event.is_pressed():
					GlobalCameraSettings.set_camera_position(cameraPosition.global_position)
				#print("action_left pressed: viewport_entered is ", viewport_entered)
					Input.action_press("pan_view")
					
				#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
			else:
				
				Input.action_release("pan_view")
			#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				

	if event.is_action_pressed("action_zoom_in"):	
		# Max allowed Zoom
		GlobalCameraSettings.zoom_in()
		
	if event.is_action_pressed("action_zoom_out"):
		GlobalCameraSettings.zoom_out()
		
func _physics_process(delta):
	var speed = 100 * delta
	
	if Input.is_action_pressed("pan_view"):
		if motion.abs() != still:
			cameraPosition.translate(-motion.round() * floor(speed))
			motion = still #Do not forget to reset your frame-time variables!		
	
				
func _on_force_update_position(position):
	if(cameraPosition != null):	
		cameraPosition.set_deferred("global_position", position)
