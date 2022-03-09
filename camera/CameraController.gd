extends Node2D
onready var cameraPosition = $CameraPosition
onready var camera = $CameraPosition/Camera
var motion = Vector2()
const still = Vector2(0, 0)
const rect_pos_initial = Vector2()
const MAX_ZOOM = Vector2(2,2)
const MIN_ZOOM = Vector2(0.3, 0.3)
const DEFAULT_ZOOM = Vector2(0.4, 0.4)
var viewport_entered = true

func _input(event):
	if event is InputEventMouseMotion:
		motion = event.relative 
		
	
	if event is InputEventMouse:
		if event.is_action("action_left"):
			if event.is_pressed():
				#print("action_left pressed: viewport_entered is ", viewport_entered)
				if viewport_entered:
					Input.action_press("pan_view")
				#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
			else:
				Input.action_release("pan_view")
			#	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				

	if event.is_action_pressed("action_zoom_in"):	
		# Max allowed Zoom
		if camera.zoom >= MIN_ZOOM:
			if camera.zoom == MAX_ZOOM:
				camera.zoom -= Vector2(1, 1)
			else: 
				camera.zoom -= Vector2(0.2, 0.2)
		
	if event.is_action_pressed("action_zoom_out"):
		if camera.zoom < MAX_ZOOM:
				camera.zoom += Vector2(0.2, 0.2)
		
		
func _physics_process(delta):
		var speed = 100 * delta
		
		if Input.is_action_pressed("pan_view"):
			if motion.abs() != still:
				cameraPosition.translate(-motion.round() * floor(speed))
				motion = still #Do not forget to reset your frame-time variables!		
					
		
func _on_CenterContainer_mouse_entered():
	viewport_entered = true
	

func _on_CenterContainer_mouse_exited():
	viewport_entered = false

func _on_Player_initial_position(position):
	if(cameraPosition != null):	
		cameraPosition.set_deferred("global_position", position)
