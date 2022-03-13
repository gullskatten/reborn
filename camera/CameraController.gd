extends Node2D
onready var cameraPosition = $CameraPosition
onready var camera = $CameraPosition/Camera
var motion = Vector2()
const still = Vector2(0, 0)
const rect_pos_initial = Vector2()
const MAX_ZOOM = Vector2(2,2)
const MIN_ZOOM = Vector2(0.2, 0.2)
const DEFAULT_ZOOM = Vector2(0.4, 0.4)
const DISABLED_ZOOM = Vector2(1.2, 1.2)
const ZOOM_FACTOR = Vector2(0.4, 0.4)
const MIN_ZOOM_FACTOR = Vector2(0.2, 0.2)

func _input(event):
	if event is InputEventMouseMotion:
		motion = event.relative 
	
	if event is InputEventMouse:
		if event.is_action("action_left"):
			if event.is_pressed():
				#print("action_left pressed: viewport_entered is ", viewport_entered)
					Input.action_press("pan_view")
				#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
			else:
				Input.action_release("pan_view")
			#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				

	if event.is_action_pressed("action_zoom_in"):	
		# Max allowed Zoom
		if camera.zoom >= MIN_ZOOM:
			if camera.zoom == MIN_ZOOM:
				camera.zoom = ZOOM_FACTOR
			
			if camera.zoom == MAX_ZOOM:
				camera.zoom -= ZOOM_FACTOR
			else: 
				if camera.zoom == ZOOM_FACTOR:
					camera.zoom -= MIN_ZOOM_FACTOR
				else:
					camera.zoom -= ZOOM_FACTOR
		# Removes jitter in tiles
		if camera.zoom == DISABLED_ZOOM:
			camera.zoom = Vector2(0.8, 0.8)
		
		print(camera.zoom)
	if event.is_action_pressed("action_zoom_out"):
		if camera.zoom == MIN_ZOOM:
				camera.zoom = ZOOM_FACTOR
				
		elif camera.zoom < MAX_ZOOM:
				camera.zoom += ZOOM_FACTOR
		# Removes jitter in tiles
		if camera.zoom == DISABLED_ZOOM:
			camera.zoom = Vector2(1.6, 1.6)
		print(camera.zoom)
func _physics_process(delta):
	var speed = 100 * delta
	
	if Input.is_action_pressed("pan_view"):
		if motion.abs() != still:
			cameraPosition.translate(-motion.round() * floor(speed))
			motion = still #Do not forget to reset your frame-time variables!		
				
func _on_Player_initial_position(position):
	if(cameraPosition != null):	
		cameraPosition.set_deferred("global_position", position)
